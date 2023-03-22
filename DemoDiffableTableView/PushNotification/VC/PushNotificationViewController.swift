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
    
    /// 宣告UITableViewDiffableDataSource
    var dataSource: UITableViewDiffableDataSource<String, NotificationInfo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchData()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        // 使用UITableViewDiffableDataSource取代
        // tableView.dataSource = self
        self.tableView.bounces = true

        self.tableView.rowHeight = UITableView.automaticDimension

        // 沒有資料的cell欄位隱藏分隔線
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    /// 設定DataSource與Cell
    private func setupDataSource() {
        self.dataSource = UITableViewDiffableDataSource<String, NotificationInfo>(tableView: self.tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            // 取代cellForRowAt
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell

            cell.update(title: model.content)
            return cell
        })

        self.tableView.dataSource = self.dataSource
    }

    /// 使用快照apply自動差異更新，取代reloadData
    private func apply() {
        var snapshot = NSDiffableDataSourceSnapshot<String, NotificationInfo>()

        // 設定快照內的section
        let sections = self.viewModel.getSections()
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard let models = viewModel.getModels(at: section) else { return }

            // 設定每個section內的row
            snapshot.appendItems(models, toSection: section)
        }
        // 新舊快照比對，取代reloadData
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Action
extension PushNotificationViewController {
    /// 點擊新增
    /// - Parameter sender: UIButton
    @IBAction func didPressPushButton(_ sender: UIButton) {
        self.viewModel.addNotification()
    }

    /// 點擊刪除
    /// - Parameter sender: UIButton
    @IBAction func didPressDeleteButton(_ sender: Any) {
        self.viewModel.removeNotification()
    }
    
    /// 點擊寫入多筆
    /// - Parameter sender: UIButton
    @IBAction func didPressAllShuffledDataButton(_ sender: UIButton) {
        self.viewModel.addAllShuffledModels()
    }
    
    /// 點擊排序
    /// - Parameter sender: UIButton
    @IBAction func didPressSortedButton(_ sender: UIButton) {
        self.viewModel.sortModels()
    }
}

/// iOS 13的Section view要用原始的UITableViewDelegate串接
extension PushNotificationViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sections = self.viewModel.getSections()

        guard sections.indices.contains(section) else { return nil }

        let sectionModel = sections[section]

        let label = UILabel()

        label.text = sectionModel
        label.backgroundColor = .yellow
        return label
    }
}

// MARK: - PushNotificationViewModelDelegate
extension PushNotificationViewController: PushNotificationViewModelDelegate {
    func fetchDataSuccess() {
        self.apply()
    }
}
