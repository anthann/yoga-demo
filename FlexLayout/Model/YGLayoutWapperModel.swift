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
    /// YogaKit的默认值是.column。CSS的默认值可能是.row
    var flexDirection: YGFlexDirection = .column
    var justifyContent: YGJustify?
    var alignContent: YGAlign?
    var alignItems: YGAlign?
    var alignSelf: YGAlign?
    var position: YGPositionType?
    var flexWrap: YGWrap?
    var overflow: YGOverflow?
    var display: YGDisplay?
    var flexGrow: CGFloat?
    var flexShrink: CGFloat?
    var flexBasis: YGValue?
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
