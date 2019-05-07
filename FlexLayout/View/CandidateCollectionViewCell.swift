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
                shapedLayer.fillColor = UIColor(hexString: model.colorString).cgColor
            } else {
                shapedLayer.fillColor = UIColor.white.cgColor
            }
        }
    }
    
    let shapedLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 80, y: 0))
        path.addLine(to: CGPoint(x: 20, y: 90))
        path.addLine(to: CGPoint(x: 160, y: 90))
        path.addLine(to: CGPoint(x: 220, y: 0))
        path.close()
        shapedLayer.path = path.cgPath
        self.contentView.layer.addSublayer(shapedLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapedLayer.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        model = nil
        shapedLayer.fillColor = UIColor.white.cgColor
    }
}
