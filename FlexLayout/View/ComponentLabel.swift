//
//  ComponentLabel.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

class ComponentLabel: UILabel, ComponentProtocol {
    lazy var selectionGustureRecognizer: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(gr)
        return gr
    }()
    
    weak var delegate: ComponentHolderProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "This is a Label"
        backgroundColor = UIColor.random()
        self.configureLayout { (layout) in
            layout.isEnabled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        delegate?.onTapComponent(sender: self)
    }
}
