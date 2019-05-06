//
//  BGSTableViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/6.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

enum BGS: Int {
    case basic = 1
    case grow
    case shrink
}

class BGSTableViewCell: UITableViewCell {
    static let ReuseIdentifier: String = "BGSTableViewCellReuseId"
    
    let basisTextField = UITextField()
    let growTextField = UITextField()
    let shrinkTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        basisTextField.tag = BGS.basic.rawValue
        basisTextField.keyboardType = .asciiCapableNumberPad
        basisTextField.autocorrectionType = .no
        basisTextField.autocapitalizationType = .none
        basisTextField.textAlignment = .center
        basisTextField.placeholder = "auto"
        basisTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(basisTextField)
        basisTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        growTextField.tag = BGS.grow.rawValue
        growTextField.keyboardType = .asciiCapableNumberPad
        growTextField.autocorrectionType = .no
        growTextField.autocapitalizationType = .none
        growTextField.textAlignment = .center
        growTextField.placeholder = "0"
        growTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(growTextField)
        growTextField.snp.makeConstraints { (make) in
            make.left.equalTo(basisTextField.snp.right).offset(16)
            make.width.equalTo(basisTextField.snp.width)
            make.height.equalTo(40)
        }
        
        shrinkTextField.tag = BGS.shrink.rawValue
        shrinkTextField.keyboardType = .asciiCapableNumberPad
        shrinkTextField.autocorrectionType = .no
        shrinkTextField.autocapitalizationType = .none
        shrinkTextField.textAlignment = .center
        shrinkTextField.placeholder = "1"
        shrinkTextField.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(shrinkTextField)
        shrinkTextField.snp.makeConstraints { (make) in
            make.left.equalTo(growTextField.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(basisTextField.snp.width)
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
        
        basisTextField.text = nil
        basisTextField.placeholder = "auto"
        basisTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        shrinkTextField.text = nil
        shrinkTextField.placeholder = "1"
        shrinkTextField.removeTarget(nil, action: nil, for: .touchUpInside)
        growTextField.text = nil
        growTextField.placeholder = "0"
        growTextField.removeTarget(nil, action: nil, for: .touchUpInside)
    }

}
