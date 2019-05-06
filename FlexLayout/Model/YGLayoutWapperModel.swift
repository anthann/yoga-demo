//
//  YGLayoutWapperModel.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/5.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import YogaKit

/// Swift Wrapper of YGLayout
/// 对于默认值不明确的属性，使用optional作为缺省值
struct YGLayoutWapperModel {
    var direction: YGDirection = .LTR
    var flexDirection: YGFlexDirection = .row
    var justifyContent: YGJustify = .flexStart
    var alignContent: YGAlign = .flexStart
    var alignItems: YGAlign = .stretch
    var alignSelf: YGAlign = .auto
    var position: YGPositionType = .relative
    var flexWrap: YGWrap = .noWrap
    var overflow: YGOverflow?
    var display: YGDisplay?
    var flexGrow: CGFloat = 0.0
    var flexShrink: CGFloat = 1.0
    var flexBasis: YGValueWrapper = .auto
    var left: YGValueWrapper?
    var top: YGValueWrapper?
    var right: YGValueWrapper?
    var bottom: YGValueWrapper?
    var start: YGValueWrapper?
    var end: YGValueWrapper?
    var marginLeft: YGValueWrapper?
    var marginTop: YGValueWrapper?
    var marginRight: YGValueWrapper?
    var marginBottom: YGValueWrapper?
    var marginStart: YGValueWrapper?
    var marginEnd: YGValueWrapper?
    var marginHorizontal: YGValueWrapper?
    var marginVertical: YGValueWrapper?
    var margin: YGValueWrapper?
    var paddingLeft: YGValueWrapper?
    var paddingTop: YGValueWrapper?
    var paddingRight: YGValueWrapper?
    var paddingBottom: YGValueWrapper?
    var paddingStart: YGValueWrapper?
    var paddingEnd: YGValueWrapper?
    var paddingHorizontal: YGValueWrapper?
    var paddingVertical: YGValueWrapper?
    var padding: YGValueWrapper?
    var width: YGValueWrapper?
    var height: YGValueWrapper?
    var minWidth: YGValueWrapper?
    var minHeight: YGValueWrapper?
    var maxWidth: YGValueWrapper?
    var maxHeight: YGValueWrapper?
    var aspectRatio: CGFloat?
}

extension YGLayoutWapperModel {
    var actualPaddingLeft: YGValueWrapper? {
        if let p = paddingLeft {
            return p
        } else if let p = paddingHorizontal {
            return p
        } else if let p = padding {
            return p
        } else {
            return nil
        }
    }
    
    var actualPaddingRight: YGValueWrapper? {
        if let p = paddingRight {
            return p
        } else if let p = paddingHorizontal {
            return p
        } else if let p = padding {
            return p
        } else {
            return nil
        }
    }
    
    var actualPaddingTop: YGValueWrapper? {
        if let p = paddingTop {
            return p
        } else if let p = paddingVertical {
            return p
        } else if let p = padding {
            return p
        } else {
            return nil
        }
    }
    
    var actualPaddingBottom: YGValueWrapper? {
        if let p = paddingBottom {
            return p
        } else if let p = paddingVertical {
            return p
        } else if let p = padding {
            return p
        } else {
            return nil
        }
    }
    
    var actualMarginLeft: YGValueWrapper? {
        if let p = marginLeft {
            return p
        } else if let p = marginHorizontal {
            return p
        } else if let p = margin {
            return p
        } else {
            return nil
        }
    }
    
    var actualMarginRight: YGValueWrapper? {
        if let p = marginRight {
            return p
        } else if let p = marginHorizontal {
            return p
        } else if let p = margin {
            return p
        } else {
            return nil
        }
    }
    
    var actualMarginTop: YGValueWrapper? {
        if let p = marginTop {
            return p
        } else if let p = marginVertical {
            return p
        } else if let p = margin {
            return p
        } else {
            return nil
        }
    }
    
    var actualMarginBottom: YGValueWrapper? {
        if let p = marginBottom {
            return p
        } else if let p = marginVertical {
            return p
        } else if let p = margin {
            return p
        } else {
            return nil
        }
    }
}
