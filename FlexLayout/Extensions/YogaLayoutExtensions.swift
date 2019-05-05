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
