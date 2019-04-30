//
//  AddNodeTableViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

protocol AddNodeCellProtocol: AnyObject {
    func onAddChildNode(sender: AddNodeTableViewCell, target: UIButton)
    func onRemoveNode(sender: AddNodeTableViewCell, target: UIButton)
}

class AddNodeTableViewCell: UITableViewCell {
    static let ReuseIdentifier: String = "AddNodeTableViewCellReuseId"
    
    weak var delegate: AddNodeCellProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let addButton = UIButton()
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addButton.setTitle("Add Child Node", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.backgroundColor = UIColor.brand100()
        addButton.addTarget(self, action: #selector(onAddChildNode), for: .touchUpInside)
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(contentView.snp.centerX).offset(-8)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        let removeButton = UIButton()
        removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        removeButton.setTitle("Remove Node", for: .normal)
        removeButton.setTitleColor(UIColor.white, for: .normal)
        removeButton.backgroundColor = UIColor.red100()
        removeButton.addTarget(self, action: #selector(onRemoveNode), for: .touchUpInside)
        contentView.addSubview(removeButton)
        removeButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.centerX).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalTo(addButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onAddChildNode(sender: UIButton) {
        delegate?.onAddChildNode(sender: self, target: sender)
    }
    
    @objc func onRemoveNode(sender: UIButton) {
        delegate?.onRemoveNode(sender: self, target: sender)
    }
    
}
