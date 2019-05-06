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
    var direction: YGDirection?
    var flexDirection: YGFlexDirection = .row
    var justifyContent: YGJustify = .flexStart
    var alignContent: YGAlign = .flexStart
    var alignItems: YGAlign = .stretch
    var alignSelf: YGAlign = .auto
    var position: YGPositionType?
    var flexWrap: YGWrap = .noWrap
    var overflow: YGOverflow?
    var display: YGDisplay?
    var flexGrow: CGFloat = 0.0
    var flexShrink: CGFloat = 1.0
    var flexBasis: YGValue? = YGValue(value: 0, unit: .auto)
    var left: YGValue?
    var top: YGValue?
    var right: YGValue?
    var bottom: YGValue?
    var start: YGValue?
    var end: YGValue?
    var marginLeft: YGValue?
    var marginTop: YGValue?
    var marginRight: YGValue?
    var marginBottom: YGValue?
    var marginStart: YGValue?
    var marginEnd: YGValue?
    var marginHorizontal: YGValue?
    var marginVertical: YGValue?
    var margin: YGValue?
    var paddingLeft: YGValue?
    var paddingTop: YGValue?
    var paddingRight: YGValue?
    var paddingBottom: YGValue?
    var paddingStart: YGValue?
    var paddingEnd: YGValue?
    var paddingHorizontal: YGValue?
    var paddingVertical: YGValue?
    var padding: YGValue?
    var width: YGValue?
    var height: YGValue?
    var minWidth: YGValue?
    var minHeight: YGValue?
    var maxWidth: YGValue?
    var maxHeight: YGValue?
    var aspectRatio: CGFloat?
}

extension YGLayoutWapperModel {
    var actualPaddingLeft: YGValue? {
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
    
    var actualPaddingRight: YGValue? {
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
    
    var actualPaddingTop: YGValue? {
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
    
    var actualPaddingBottom: YGValue? {
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
    
    var actualMarginLeft: YGValue? {
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
    
    var actualMarginRight: YGValue? {
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
    
    var actualMarginTop: YGValue? {
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
    
    var actualMarginBottom: YGValue? {
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
