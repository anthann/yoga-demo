//
//  SizeTableViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/6.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

enum SizeDimension: Int {
    case width = 1
    case height
}

class SizeTableViewCell: UITableViewCell {
    static let ReuseIdentifier: String = "SizeTableViewCellReuseId"
    
    let widthTextField = UITextField()
    let heightTextField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        widthTextField.tag = SizeDimension.width.rawValue
        widthTextField.keyboardType = .asciiCapableNumberPad
        widthTextField.autocorrectionType = .no
        widthTextField.autocapitalizationType = .none
        widthTextField.textAlignment = .center
        widthTextField.placeholder = "0"
        widthTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(widthTextField)
        widthTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(contentView.snp.centerX).offset(-8)
            make.height.equalTo(40)
        }
        
        heightTextField.tag = SizeDimension.height.rawValue
        heightTextField.keyboardType = .asciiCapableNumberPad
        heightTextField.autocorrectionType = .no
        heightTextField.autocapitalizationType = .none
        heightTextField.textAlignment = .center
        heightTextField.placeholder = "0"
        heightTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(heightTextField)
        heightTextField.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.centerX).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
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
        
        widthTextField.text = nil
        widthTextField.placeholder = "0"
        widthTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        heightTextField.text = nil
        heightTextField.placeholder = "0"
        heightTextField.removeTarget(nil, action: nil, for: .touchUpInside)
    }

}
