//
//  DropDownTableViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/5.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    static let ReuseIdentifier: String = "DropDownTableViewCellReuseId"
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.indigoBG100()
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        let expandImageView = UIImageView(image: UIImage(named: "icon_expand"))
        contentView.addSubview(expandImageView)
        expandImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            contentView.alpha = 0.5
        } else {
            contentView.alpha = 1.0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title = nil
        label.text = ""
    }

}
