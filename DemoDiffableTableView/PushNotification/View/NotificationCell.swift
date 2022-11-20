//
//  NotificationCell.swift
//  DemoDiffableTableView
//
//  Created by Sally Xie on 2022/11/20.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(title: String) {
        
        contentLabel.text = title
    }

}
