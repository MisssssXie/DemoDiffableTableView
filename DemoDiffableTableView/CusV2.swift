//
//  CusV2.swift
//  DemoDiffableTableView
//
//  Created by SallyXie on 2023/5/24.
//

import UIKit

@IBDesignable
class CusV2: CustomView {
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @IBOutlet weak var haha: UILabel!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //self.contentView.backgroundColor = .blue
    }
    
    // MARK: - UI Setup
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.loadInterfaceBuilder()
    }
}
