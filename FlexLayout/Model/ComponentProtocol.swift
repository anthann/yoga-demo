//
//  ComponentProtocol.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import UIKit

protocol ComponentProtocol: AnyObject {
    var selectionGustureRecognizer: UITapGestureRecognizer { get }
    var delegate: ComponentHolderProtocol? { get set }
}

protocol ComponentHolderProtocol: AnyObject {
    func onSelectComponent(sender: ComponentProtocol)
}
