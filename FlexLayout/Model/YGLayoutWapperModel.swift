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
    var marginLeft: YGValueWrapper = .point(0)
    var marginTop: YGValueWrapper = .point(0)
    var marginRight: YGValueWrapper = .point(0)
    var marginBottom: YGValueWrapper = .point(0)
    var paddingLeft: YGValueWrapper = .point(0)
    var paddingTop: YGValueWrapper = .point(0)
    var paddingRight: YGValueWrapper = .point(0)
    var paddingBottom: YGValueWrapper = .point(0)
    var width: YGValueWrapper = .auto
    var height: YGValueWrapper = .auto
    var minWidth: YGValueWrapper = .undefined
    var minHeight: YGValueWrapper = .undefined
    var maxWidth: YGValueWrapper = .undefined
    var maxHeight: YGValueWrapper = .undefined
    var aspectRatio: CGFloat?
}
