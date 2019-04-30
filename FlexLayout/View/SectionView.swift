//
//  SectionView.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/20.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit

class SectionView: UIView, ComponentProtocol {
    enum State {
        case animated(_ componentStack: [UIView])
        case normal
        case selected(_ component: UIView)
    }

    lazy var selectionGustureRecognizer: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(onSelection))
        gr.isEnabled = false
        self.addGestureRecognizer(gr)
        return gr
    }()
    lazy var tapGustureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    var state: State = .normal {
        didSet {
            
            stateChanged()
        }
    }
    
    weak var delegate: ComponentHolderProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayout { (layout) in
            layout.isEnabled = true
        }
        
        self.addGestureRecognizer(tapGustureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flexLayout() {
        self.yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: .flexibleHeight)
    }
    
    func stateChanged() {
        switch state {
        case .normal:
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
                self?.noTransformAndVisible()
            }) { (finished) in
                self.selectionGustureRecognizer.isEnabled = false
                self.tapGustureRecognizer.isEnabled = true
            }
        case .animated(var viewStack):
            viewStack.forEach({
                if let view = $0 as? ComponentProtocol {
                    view.selectionGustureRecognizer.isEnabled = true
                }
            })
            self.selectionGustureRecognizer.isEnabled = true
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                let rotateX: CGFloat = CGFloat(Double.pi / 4.0)
                let rotateY: CGFloat = -CGFloat(Double.pi / 5.0)
                var transform = CATransform3DIdentity
                transform = CATransform3DRotate(transform, rotateY, 0, 1, 0)
                transform = CATransform3DRotate(transform, rotateX, 1, 0, 0)
                self?.layer.transform = transform
                for view in viewStack {
                    let translationY: CGFloat = -80.0
                    var subViewTransform = CATransform3DMakeTranslation(0, translationY, 0)
                    subViewTransform = CATransform3DTranslate(subViewTransform, translationY * sin(-rotateY), 0, 0)
                    view.layer.transform = subViewTransform
                }
                self?.subviews.forEach({$0.hideIrrelevantViews(hitStack: &viewStack)})
            }) { (finished) in
                
            }
        case .selected(let selected):
            selected.layer.shadowColor = UIColor.black.cgColor
            selected.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            selected.layer.shadowRadius = 5.0
            selected.layer.shadowOpacity = 1.0
        }
    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        guard case State.normal = self.state else {
            return
        }
        let location = sender.location(in: self)
        var hitStack = [UIView]()
        subviews.forEach({ hit(stack: &hitStack, view: $0, location: location) })
        if hitStack.isEmpty {
            return
        }
        self.state = .animated(hitStack)
        
    }
    
    @objc func onSelection(sender: UITapGestureRecognizer) {
        guard case State.animated(_) = self.state else {
            return
        }
        self.state = .selected(self)
        delegate?.onSelectComponent(sender: self)
    }
    
    private func hit(stack: inout [UIView], view: UIView, location: CGPoint) {
        let frame = view.convert(view.bounds, to: self)
        if !frame.contains(location) {
            return
        }
        stack.append(view)
        view.subviews.forEach({ hit(stack: &stack, view: $0, location: location) })
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//    }
//
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//
//    }
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
        self.layer.shadowColor = nil
        self.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.0
        self.layer.transform = CATransform3DIdentity
        self.alpha = 1.0
        subviews.forEach({$0.noTransformAndVisible()})
    }
}
