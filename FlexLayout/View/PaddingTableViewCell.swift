//
//  PaddingTableViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/6.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

enum Direction: Int {
    case left = 1
    case right
    case top
    case bottom
}

class PaddingTableViewCell: UITableViewCell {
    static let ReuseIdentifier: String = "PaddingTableViewCellReuseId"
    
    let topTextField = UITextField()
    let bottomTextField = UITextField()
    let leftTextField = UITextField()
    let rightTextField = UITextField()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        topTextField.tag = Direction.top.rawValue
        topTextField.keyboardType = .asciiCapableNumberPad
        topTextField.autocorrectionType = .no
        topTextField.autocapitalizationType = .none
        topTextField.textAlignment = .center
        topTextField.placeholder = "0"
        topTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(topTextField)
        topTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-4)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        bottomTextField.tag = Direction.bottom.rawValue
        bottomTextField.keyboardType = .asciiCapableNumberPad
        bottomTextField.autocorrectionType = .no
        bottomTextField.autocapitalizationType = .none
        bottomTextField.textAlignment = .center
        bottomTextField.placeholder = "0"
        bottomTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(bottomTextField)
        bottomTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        leftTextField.tag = Direction.left.rawValue
        leftTextField.keyboardType = .asciiCapableNumberPad
        leftTextField.autocorrectionType = .no
        leftTextField.autocapitalizationType = .none
        leftTextField.textAlignment = .center
        leftTextField.placeholder = "0"
        leftTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(leftTextField)
        leftTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(label.snp.left).offset(-4)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        rightTextField.tag = Direction.right.rawValue
        rightTextField.keyboardType = .asciiCapableNumberPad
        rightTextField.autocorrectionType = .no
        rightTextField.autocapitalizationType = .none
        rightTextField.textAlignment = .center
        rightTextField.placeholder = "0"
        rightTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(rightTextField)
        rightTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(label.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        topTextField.text = nil
        topTextField.placeholder = "0"
        topTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        bottomTextField.text = nil
        bottomTextField.placeholder = "0"
        bottomTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        leftTextField.text = nil
        leftTextField.placeholder = "0"
        leftTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        rightTextField.text = nil
        rightTextField.placeholder = "0"
        rightTextField.removeTarget(nil, action: nil, for: .touchUpInside)
    }
}
