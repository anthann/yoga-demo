//
//  YogaLayoutExtensions.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/5.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import YogaKit

extension YGFlexDirection {
    var title: String {
        switch self {
        case .column:
            return "COLUMN"
        case .columnReverse:
            return "COLUMN REVERSE"
        case .row:
            return "ROW"
        case .rowReverse:
            return "ROW REVERSE"
        @unknown default:
            return "UNKNOWN"
        }
    }
    
    static var allValues: [YGFlexDirection] {
        return [.column, .columnReverse, .row, .rowReverse]
    }
}

extension YGJustify {
    var title: String {
        switch self {
        case .flexStart:
            return "FLEX START"
        case .center:
            return "CENTER"
        case .flexEnd:
            return "FLEX END"
        case .spaceBetween:
            return "SPACE BETWEEN"
        case .spaceAround:
            return "SPACE AROUND"
        case .spaceEvenly:
            return "SPACE EVENLY"
        @unknown default:
            return "UNKNOWN"
        }
    }
    
    static var allValues: [YGJustify] {
        return [.flexStart, .flexEnd, .center, .spaceAround, .spaceEvenly, .spaceBetween]
    }
}

extension YGAlign {
    var title: String {
        switch self {
        case .auto:
            return "AUTO"
        case .flexStart:
             return "FLEX START"
        case .center:
            return "CENTER"
        case .flexEnd:
            return "FLEX END"
        case .stretch:
            return "STRETCH"
        case .baseline:
            return "BASELINE"
        case .spaceBetween:
            return "SPACE BETWEEN"
        case .spaceAround:
            return "SPACE AROUND"
        @unknown default:
            return "UNKNOWN"
        }
    }
    
    static var allValues: [YGAlign] {
        return [.auto, .baseline, .center, .flexStart, .flexEnd, .spaceAround, .spaceBetween, .stretch]
    }
}

extension YGWrap {
    var title: String {
        switch self {
        case .noWrap:
            return "NO WRAP"
        case .wrap:
            return "WRAP"
        case .wrapReverse:
            return "WRAP REVERSE"
        @unknown default:
            return "UNKNOWN"
        }
    }
    
    static var allValues: [YGWrap] {
        return [.noWrap, .wrap, .wrapReverse]
    }
}

extension YGValue {
    /// 只要Unit不是percent，都暂且认为是point
    var pointValue: Float? {
        if unit != .percent {
            return value
        }
        return nil
    }
}
