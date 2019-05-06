//
//  YGValueWrapper.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/6.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import YogaKit

enum YGValueWrapper {
    case auto
    case undefined
    case percent(_ value: Float)
    case point(_ value: Float)
}

extension YGValueWrapper {
    func toYGValue() -> YGValue {
        switch self {
        case .undefined:
            return YGValueUndefined
        case .auto:
            return YGValueAuto
        case .point(let value):
            return YGValue(value: value, unit: .point)
        case .percent(let value):
            return YGValue(value: value, unit: .percent)
        }
    }
}
