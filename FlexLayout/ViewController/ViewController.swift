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
//    private lazy var sectionView = SectionView()
    private lazy var layoutViewController = LayoutViewController()
    private lazy var sectionViewController = SectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Start"
//        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addChild(sectionViewController)
        sectionViewController.didMove(toParent: self)
        self.view.addSubview(sectionViewController.view)
        sectionViewController.view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 360.0, height: 300.0))
            make.centerX.equalToSuperview()
        }
        
        layoutViewController.delegate = self
        self.addChild(layoutViewController)
        layoutViewController.didMove(toParent: self)
        self.view.addSubview(layoutViewController.view)
        layoutViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(300)
        }
//        sectionView.flexLayout()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(gr)
    }

//    func setupViews() {
//        sectionView.backgroundColor = UIColor(hexString: "#C0C3ED")
//        view.addSubview(sectionView)
//        sectionView.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize(width: 375, height: 375))
//            make.center.equalToSuperview()
//        }
//    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        sectionViewController.store.dispatch(.onTapOutside)
    }
}

extension ViewController: ComponentHolderProtocol {
    func onTapComponent(sender: UIView) {
//        if let view = sender as? UIView {
//            sectionView.state = .selected(view)
//        }
    }
}

extension ViewController: LayoutViewControllerProtocol {
    func onTapAddSubView(sender: LayoutViewController) {
        sectionViewController.addView()
    }
}
