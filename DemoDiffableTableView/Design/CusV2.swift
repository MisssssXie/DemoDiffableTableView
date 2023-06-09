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
    

    @IBOutlet weak var haha: UILabel!

    // MARK: - UI Setup
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.loadInterfaceBuilder()
    }
}

#Preview {
    return CusV2()
}
