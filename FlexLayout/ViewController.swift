//
//  ViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/20.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit
import SnapKit

class ViewController: UIViewController {
    private lazy var sectionView = SectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Start"
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sectionView.flexLayout()
    }

    func setupViews() {
        sectionView.backgroundColor = UIColor(hexString: "#C0C3ED")
        view.addSubview(sectionView)
        sectionView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 375, height: 375))
            make.center.equalToSuperview()
        }
    }

}

