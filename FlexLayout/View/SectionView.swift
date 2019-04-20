//
//  SectionView.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/20.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit

class SectionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayout { (layout) in
            layout.isEnabled = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tapGesture)
        
        for i in 0..<3 {
            let view = UIView()
            view.backgroundColor = UIColor.random()
            view.configureLayout { (layout) in
                layout.isEnabled = true
                layout.width = YGValue(value: 200, unit: .point)
                layout.height = YGValue(value: 100, unit: .point)
                if i == 2 {
                    layout.flexDirection = .row
                }
            }
            self.addSubview(view)
            if i == 2 {
                for _ in 0..<2 {
                    let subView = UIView()
                    subView.backgroundColor = UIColor.random()
                    subView.configureLayout { (layout) in
                        layout.isEnabled = true
                        layout.width = YGValue(value: 50, unit: .percent)
                        layout.height = YGValue(value: 100, unit: .point)
                    }
                    view.addSubview(subView)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flexLayout() {
        self.yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: .flexibleHeight)
    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        if !CATransform3DIsIdentity(self.layer.transform) {
            backToNormal()
            return
        }
        let location = sender.location(in: self)
        var hitStack = [UIView]()
        subviews.forEach({ hit(stack: &hitStack, view: $0, location: location) })
        if hitStack.isEmpty {
            return
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            let rotateX: CGFloat = CGFloat(Double.pi / 4.0)
            let rotateY: CGFloat = -CGFloat(Double.pi / 5.0)
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotateY, 0, 1, 0)
            transform = CATransform3DRotate(transform, rotateX, 1, 0, 0)
            self?.layer.transform = transform
            for view in hitStack {
                let translationY: CGFloat = -80.0
                var subViewTransform = CATransform3DMakeTranslation(0, translationY, 0)
                subViewTransform = CATransform3DTranslate(subViewTransform, translationY * sin(-rotateY), 0, 0)
                view.layer.transform = subViewTransform
            }
            self?.subviews.forEach({$0.hideIrrelevantViews(hitStack: &hitStack)})
        }) { (finished) in
            
        }
    }
    
    private func hit(stack: inout [UIView], view: UIView, location: CGPoint) {
        let frame = view.convert(view.bounds, to: self)
        if !frame.contains(location) {
            return
        }
        stack.append(view)
        view.subviews.forEach({ hit(stack: &stack, view: $0, location: location) })
    }
    
    private func backToNormal() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            self?.noTransformAndVisible()
        }) { (finished) in
            
        }
    }
}

fileprivate extension UIView {
    func hideIrrelevantViews(hitStack: inout [UIView]) {
        if !hitStack.contains(self) {
            self.alpha = 0.0
        } else {
            self.alpha = 1.0
            subviews.forEach({$0.hideIrrelevantViews(hitStack: &hitStack)})
        }
    }
    
    func noTransformAndVisible() {
        self.layer.transform = CATransform3DIdentity
        self.alpha = 1.0
        subviews.forEach({$0.noTransformAndVisible()})
    }
}
