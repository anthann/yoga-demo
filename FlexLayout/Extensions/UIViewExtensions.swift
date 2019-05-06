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
            if let start = wrapperModel.start {
                layout.start = start.toYGValue()
            }
            if let end = wrapperModel.end {
                layout.end = end.toYGValue()
            }
            if let marginLeft = wrapperModel.marginLeft {
                layout.marginLeft = marginLeft.toYGValue()
            }
            if let marginTop = wrapperModel.marginTop {
                layout.marginTop = marginTop.toYGValue()
            }
            if let marginRight = wrapperModel.marginRight {
                layout.marginRight = marginRight.toYGValue()
            }
            if let marginBottom = wrapperModel.marginBottom {
                layout.marginBottom = marginBottom.toYGValue()
            }
            if let marginStart = wrapperModel.marginStart {
                layout.marginStart = marginStart.toYGValue()
            }
            if let marginEnd = wrapperModel.marginEnd {
                layout.marginEnd = marginEnd.toYGValue()
            }
            if let marginHorizontal = wrapperModel.marginHorizontal {
                layout.marginHorizontal = marginHorizontal.toYGValue()
            }
            if let marginVertical = wrapperModel.marginVertical {
                layout.marginVertical = marginVertical.toYGValue()
            }
            if let margin = wrapperModel.margin {
                layout.margin = margin.toYGValue()
            }
            if let paddingLeft = wrapperModel.paddingLeft {
                layout.paddingLeft = paddingLeft.toYGValue()
            }
            if let paddingTop = wrapperModel.paddingTop {
                layout.paddingTop = paddingTop.toYGValue()
            }
            if let paddingRight = wrapperModel.paddingRight {
                layout.paddingRight = paddingRight.toYGValue()
            }
            if let paddingBottom = wrapperModel.paddingBottom {
                layout.paddingBottom = paddingBottom.toYGValue()
            }
            if let paddingStart = wrapperModel.paddingStart {
                layout.paddingStart = paddingStart.toYGValue()
            }
            if let paddingEnd = wrapperModel.paddingEnd {
                layout.paddingEnd = paddingEnd.toYGValue()
            }
            if let paddingHorizontal = wrapperModel.paddingHorizontal {
                layout.paddingHorizontal = paddingHorizontal.toYGValue()
            }
            if let paddingVertical = wrapperModel.paddingVertical {
                layout.paddingVertical = paddingVertical.toYGValue()
            }
            if let padding = wrapperModel.padding {
                layout.padding = padding.toYGValue()
            }
            if let width = wrapperModel.width {
                layout.width = width.toYGValue()
            }
            if let height = wrapperModel.height {
                layout.height = height.toYGValue()
            }
            if let minWidth = wrapperModel.minWidth {
                layout.minWidth = minWidth.toYGValue()
            }
            if let minHeight = wrapperModel.minHeight {
                layout.minHeight = minHeight.toYGValue()
            }
            if let maxWidth = wrapperModel.maxWidth {
                layout.maxWidth = maxWidth.toYGValue()
            }
            if let maxHeight = wrapperModel.maxHeight {
                layout.maxHeight = maxHeight.toYGValue()
            }
            if let aspectRatio = wrapperModel.aspectRatio {
                layout.aspectRatio = aspectRatio
            }
        }
    }
}
