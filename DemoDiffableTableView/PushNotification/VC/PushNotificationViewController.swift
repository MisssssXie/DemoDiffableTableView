//
//  ViewController.swift
//  DemoDiffableTableView
//
//  Created by Sally Xie on 2022/11/20.
//

import UIKit

class PushNotificationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: PushNotificationViewModel = {
        let vm = PushNotificationViewModel()
        vm.delegate = self
        
        return vm
    }()
    
    var dataSource: UITableViewDiffableDataSource<String, NotificationInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.bounces = true
//        tableView.separatorStyle = .none
//        tableView.separatorColor = .clear
//        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.rowHeight = UITableView.automaticDimension
        
        // 沒有資料的cell欄位隱藏分隔線
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    /// 設定DataSource與Cell
    private func setupDataSource() {
     
        dataSource = UITableViewDiffableDataSource<String, NotificationInfo>(tableView: tableView, cellProvider: {(tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
            cell.update(title: model.content)
            return cell
        })
        
        tableView.dataSource = dataSource
    }
    
    private func apply() {
        var snapshot = NSDiffableDataSourceSnapshot<String, NotificationInfo>()
        
        // 設定快照內的section
        snapshot.appendSections(self.viewModel.getSections())
        self.viewModel.getSections().forEach { key in
            guard let model = viewModel.getModels(at: key) else {return}
            
            // 設定每個section內的row
            snapshot.appendItems(model, toSection: key)
        }
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction func didPressPushButton(_ sender: UIButton) {
        viewModel.addNotification()
    }
    
    @IBAction func didPressDeleteButton(_ sender: Any) {
        viewModel.removeNotification()
    }
}

/// iOS 13的Section view要用原始的UITableViewDelegate串接
extension PushNotificationViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sections = viewModel.getSections()

        guard sections.indices.contains(section) else { return nil }

        let sectionModel = sections[section]

        let label = UILabel()
        
        label.text = sectionModel
        label.backgroundColor = .yellow
        return label
    }
}

/// dataSource抓取成功後
extension PushNotificationViewController: PushNotificationViewModelDelegate {
    func fetchDataSuccess() {
        apply()
    }
}
