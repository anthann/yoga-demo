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
    private lazy var layoutViewController = LayoutViewController()
    private lazy var sectionViewController = SectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Yoga"
        setupViews()
    }
    
    private func setupViews() {
        layoutViewController.currentTarget = sectionViewController.componentView
        layoutViewController.delegate = self
        self.addChild(layoutViewController)
        layoutViewController.didMove(toParent: self)
        self.view.addSubview(layoutViewController.view)
        layoutViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(300)
        }
        
        let leftMarginView = UIView()
        self.view.addSubview(leftMarginView)
        leftMarginView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
        }
        
        sectionViewController.delegate = self
        self.addChild(sectionViewController)
        sectionViewController.didMove(toParent: self)
        self.view.addSubview(sectionViewController.view)
        sectionViewController.view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: SectionViewController.PreferedWidth, height: SectionViewController.PreferedHeight))
            make.left.equalTo(leftMarginView.snp.right)
        }
        
        let rightMarginView = UIView()
        self.view.addSubview(rightMarginView)
        rightMarginView.snp.makeConstraints { (make) in
            make.left.equalTo(sectionViewController.view.snp.right)
            make.right.equalTo(layoutViewController.view.snp.left)
            make.width.equalTo(leftMarginView.snp.width)
        }
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gr.delegate = self
        self.view.addGestureRecognizer(gr)
    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        sectionViewController.store.dispatch(.onTapOutside)
    }
}

extension ViewController: LayoutViewControllerProtocol {
    func onTapAddSubView(sender: LayoutViewController) {
        sectionViewController.addView()
    }
    
    func onTapRemoveView(sender: LayoutViewController, view: UIView) {
        sectionViewController.removeView(view)
    }
    
    func setNeedsLayoutComponent(sender: LayoutViewController) {
        sectionViewController.componentView.layout()
    }
}

extension ViewController: SectionViewControllerProtocol {
    func onSelectionChange(sender: SectionViewController, selected: UIView) {
        layoutViewController.currentTarget = selected
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: view)
        if self.sectionViewController.view.frame.contains(location) || self.layoutViewController.view.frame.contains(location) {
            return false
        }
        return true
    }
}
