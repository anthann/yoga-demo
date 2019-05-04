//
//  CandidateCollectionViewCell.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/4.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

class CandidateCollectionViewCell: UICollectionViewCell {
    var model: ViewCandidateModel? {
        didSet {
            if let model = model {
                contentView.backgroundColor = UIColor(hexString: model.colorString)
            } else {
                contentView.backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        model = nil
        contentView.backgroundColor = .white
    }
}
