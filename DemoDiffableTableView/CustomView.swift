//
//  CustomView.swift
//  DemoDiffableTableView
//
//  Created by SallyXie on 2023/5/24.
//

import UIKit

class CustomView: UIView {
    // MARK: - Properties and Variables
    @IBOutlet var contentView: UIView!

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibNamed(name: String(describing: type(of: self)))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibNamed(name: String(describing: type(of: self)))
    }

    func setupView() {
        self.backgroundColor = self.color
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }

    func loadInterfaceBuilder() {
        Bundle(for: type(of: self)).loadNibNamed("\(type(of: self))", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }

    // MARK: - Private Method
    func loadNibNamed(name: String) {
        guard Bundle.main.path(forResource: name, ofType: "nib") != nil
        else { return }

        Bundle.main.loadNibNamed(name, owner: self, options: nil)

        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    // MARK: - Properties
    @IBInspectable  var color: UIColor = .blue {
        didSet {
            self.backgroundColor = self.color
        }
    }

    @IBInspectable  var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

    var shadowColor: UIColor = .black {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }

    var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }

    var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }

    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }

    var borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
}
