//
//  ComponentImageView.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit

class ComponentImageView: UIImageView, ComponentProtocol {
    lazy var selectionGustureRecognizer: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gr.isEnabled = false
        self.addGestureRecognizer(gr)
        return gr
    }()
    
    weak var delegate: ComponentHolderProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.random()
        self.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(value: 100, unit: .point)
            layout.height = YGValue(value: 100, unit: .point)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        delegate?.onSelectComponent(sender: self)
    }
}
