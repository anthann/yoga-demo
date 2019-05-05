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
            
            if let direction = wrapperModel.direction {
                layout.direction = direction
            }
            layout.flexDirection = wrapperModel.flexDirection
            layout.justifyContent = wrapperModel.justifyContent
            layout.alignContent = wrapperModel.alignContent
            layout.alignItems = wrapperModel.alignItems
            layout.alignSelf = wrapperModel.alignSelf
            if let position = wrapperModel.position {
                layout.position = position
            }
            layout.flexWrap = wrapperModel.flexWrap
            if let overflow = wrapperModel.overflow {
                layout.overflow = overflow
            }
            if let display = wrapperModel.display {
                layout.display = display
            }
            layout.flexGrow = wrapperModel.flexGrow
            layout.flexShrink = wrapperModel.flexShrink
            if let flexBasis = wrapperModel.flexBasis {
                layout.flexBasis = flexBasis
            }
            if let left = wrapperModel.left {
                layout.left = left
            }
            if let top = wrapperModel.top {
                layout.top = top
            }
            if let right = wrapperModel.right {
                layout.right = right
            }
            if let bottom = wrapperModel.bottom {
                layout.bottom = bottom
            }
            if let start = wrapperModel.start {
                layout.start = start
            }
            if let end = wrapperModel.end {
                layout.end = end
            }
            if let marginLeft = wrapperModel.marginLeft {
                layout.marginLeft = marginLeft
            }
            if let marginTop = wrapperModel.marginTop {
                layout.marginTop = marginTop
            }
            if let marginRight = wrapperModel.marginRight {
                layout.marginRight = marginRight
            }
            if let marginBottom = wrapperModel.marginBottom {
                layout.marginBottom = marginBottom
            }
            if let marginStart = wrapperModel.marginStart {
                layout.marginStart = marginStart
            }
            if let marginEnd = wrapperModel.marginEnd {
                layout.marginEnd = marginEnd
            }
            if let marginHorizontal = wrapperModel.marginHorizontal {
                layout.marginHorizontal = marginHorizontal
            }
            if let marginVertical = wrapperModel.marginVertical {
                layout.marginVertical = marginVertical
            }
            if let margin = wrapperModel.margin {
                layout.margin = margin
            }
            if let paddingLeft = wrapperModel.paddingLeft {
                layout.paddingLeft = paddingLeft
            }
            if let paddingTop = wrapperModel.paddingTop {
                layout.paddingTop = paddingTop
            }
            if let paddingRight = wrapperModel.paddingRight {
                layout.paddingRight = paddingRight
            }
            if let paddingBottom = wrapperModel.paddingBottom {
                layout.paddingBottom = paddingBottom
            }
            if let paddingStart = wrapperModel.paddingStart {
                layout.paddingStart = paddingStart
            }
            if let paddingEnd = wrapperModel.paddingEnd {
                layout.paddingEnd = paddingEnd
            }
            if let paddingHorizontal = wrapperModel.paddingHorizontal {
                layout.paddingHorizontal = paddingHorizontal
            }
            if let paddingVertical = wrapperModel.paddingVertical {
                layout.paddingVertical = paddingVertical
            }
            if let padding = wrapperModel.padding {
                layout.padding = padding
            }
            if let width = wrapperModel.width {
                layout.width = width
            }
            if let height = wrapperModel.height {
                layout.height = height
            }
            if let minWidth = wrapperModel.minWidth {
                layout.minWidth = minWidth
            }
            if let minHeight = wrapperModel.minHeight {
                layout.minHeight = minHeight
            }
            if let maxWidth = wrapperModel.maxWidth {
                layout.maxWidth = maxWidth
            }
            if let maxHeight = wrapperModel.maxHeight {
                layout.maxHeight = maxHeight
            }
            if let aspectRatio = wrapperModel.aspectRatio {
                layout.aspectRatio = aspectRatio
            }
        }
    }
}
