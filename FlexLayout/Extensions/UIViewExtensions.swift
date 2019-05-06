//
//  UIViewExtensions.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/5.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

private var layoutModelKey: Void?

internal extension UIView {
    var layoutModel: YGLayoutWapperModel? {
        get {
            return objc_getAssociatedObject(self, &layoutModelKey) as? YGLayoutWapperModel
        }
        set(newValue) {
            objc_setAssociatedObject(self, &layoutModelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /**
     Defines how the `layout(mode:)` method layout its flex items.
     */
    enum LayoutMode {
        /// This is the default mode when no parameter is specified. Children are layouted **inside** the container's size (width and height).
        case fitContainer
        /// In this mode, children are layouted **using only the container's width**. The container's height will be adjusted to fit the flexbox's children
        case adjustHeight
        /// In this mode, children are layouted **using only the container's height**. The container's width will be adjusted to fit the flexbox's children
        case adjustWidth
    }

    /**
     The method layout the flex container's children
     
     - Parameter mode: specify the layout mod (LayoutMode).
     */
    func layout(mode: LayoutMode = .fitContainer) {
        if mode  == .fitContainer {
            yoga.applyLayout(preservingOrigin: true)
        } else {
            yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: mode == .adjustWidth ? YGDimensionFlexibility.flexibleWidth : YGDimensionFlexibility.flexibleHeight)
        }
    }
    
    func applyLayoutModel() {
        guard let model = layoutModel else {
            return
        }
        applyLayoutModel(model)
    }
    
    func applyLayoutModel(_ wrapperModel: YGLayoutWapperModel) {
        self.configureLayout { (layout) in
            layout.isEnabled = true
            
            layout.direction = wrapperModel.direction
            layout.flexDirection = wrapperModel.flexDirection
            layout.justifyContent = wrapperModel.justifyContent
            layout.alignContent = wrapperModel.alignContent
            layout.alignItems = wrapperModel.alignItems
            layout.alignSelf = wrapperModel.alignSelf
            layout.position = wrapperModel.position
            layout.flexWrap = wrapperModel.flexWrap
            if let overflow = wrapperModel.overflow {
                layout.overflow = overflow
            }
            if let display = wrapperModel.display {
                layout.display = display
            }
            layout.flexGrow = wrapperModel.flexGrow
            layout.flexShrink = wrapperModel.flexShrink
            layout.flexBasis = wrapperModel.flexBasis.toYGValue()
            if let left = wrapperModel.left {
                layout.left = left.toYGValue()
            }
            if let top = wrapperModel.top {
                layout.top = top.toYGValue()
            }
            if let right = wrapperModel.right {
                layout.right = right.toYGValue()
            }
            if let bottom = wrapperModel.bottom {
                layout.bottom = bottom.toYGValue()
            }
            layout.marginLeft = wrapperModel.marginLeft.toYGValue()
            layout.marginTop = wrapperModel.marginTop.toYGValue()
            layout.marginRight = wrapperModel.marginRight.toYGValue()
            layout.marginBottom = wrapperModel.marginBottom.toYGValue()
            layout.paddingLeft = wrapperModel.paddingLeft.toYGValue()
            layout.paddingTop = wrapperModel.paddingTop.toYGValue()
            layout.paddingRight = wrapperModel.paddingRight.toYGValue()
            layout.paddingBottom = wrapperModel.paddingBottom.toYGValue()
            layout.width = wrapperModel.width.toYGValue()
            layout.height = wrapperModel.height.toYGValue()
            layout.minWidth = wrapperModel.minWidth.toYGValue()
            layout.minHeight = wrapperModel.minHeight.toYGValue()
            layout.maxWidth = wrapperModel.maxWidth.toYGValue()
            layout.maxHeight = wrapperModel.maxHeight.toYGValue()
            if let aspectRatio = wrapperModel.aspectRatio {
                layout.aspectRatio = aspectRatio
            }
        }
    }
}
