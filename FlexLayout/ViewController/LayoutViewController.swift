//
//  LayoutViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit
import RxSwift

protocol LayoutViewControllerProtocol: AnyObject {
    func onTapAddSubView(sender: LayoutViewController)
    func setNeedsLayoutComponent(sender: LayoutViewController)
}

fileprivate enum Direction {
    case left
    case right
    case top
    case bottom
}

class LayoutViewController: UIViewController {
    enum Sections: Int {
        case addNode = 0
        case flexDirection
        case justifyContent
        case alignItems
        case alignSelf
        case alignContent
        case flexWrap
        case padding
        case max
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(AddNodeTableViewCell.self, forCellReuseIdentifier: AddNodeTableViewCell.ReuseIdentifier)
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.ReuseIdentifier)
        tableView.register(PaddingTableViewCell.self, forCellReuseIdentifier: PaddingTableViewCell.ReuseIdentifier)
        return tableView
    }()
    
    weak var delegate: LayoutViewControllerProtocol?
    weak var currentTarget: UIView? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}

extension LayoutViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.max.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .addNode:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddNodeTableViewCell.ReuseIdentifier) as! AddNodeTableViewCell
            cell.delegate = self
            return cell
        case .flexDirection:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.flexDirection.title
            return cell
        case .justifyContent:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.justifyContent.title
            return cell
        case .alignItems:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.alignItems.title
            return cell
        case .alignSelf:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.alignSelf.title
            return cell
        case .alignContent:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.alignContent.title
            return cell
        case .flexWrap:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.flexWrap.title
            return cell
        case .padding:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaddingTableViewCell.ReuseIdentifier) as! PaddingTableViewCell
            cell.label.text = "PADDING"
            cell.leftTextField.placeholder = "0"
            cell.rightTextField.placeholder = "0"
            cell.topTextField.placeholder = "0"
            cell.bottomTextField.placeholder = "0"
            if let left = currentTarget?.layoutModel?.actualPaddingLeft, let value = left.pointValue {
                cell.leftTextField.text = String(format: "%.1f", value)
            }
            if let right = currentTarget?.layoutModel?.actualPaddingRight, let value = right.pointValue {
                cell.rightTextField.text = String(format: "%.1f", value)
            }
            if let top = currentTarget?.layoutModel?.actualPaddingTop, let value = top.pointValue {
                cell.topTextField.text = String(format: "%.1f", value)
            }
            if let bottom = currentTarget?.layoutModel?.actualPaddingBottom, let value = bottom.pointValue {
                cell.bottomTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .max:
            fatalError()
        }
    }
}

extension LayoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Sections(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .addNode:
            return nil
        case .flexDirection:
            return "FLEX DIRECTION"
        case .justifyContent:
            return "JUSTIFY CONTENT"
        case .alignItems:
            return "ALIGH ITEMS"
        case .alignSelf:
            return "ALIGN SELF"
        case .alignContent:
            return "ALIGN CONTENT"
        case .flexWrap:
            return "FLEX WRAP"
        case .padding:
            return nil
        case .max:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Sections(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .padding:
            return CGFloat.leastNormalMagnitude
        case .addNode:
            return CGFloat.leastNormalMagnitude
        case .flexDirection:
            fallthrough
        case .justifyContent:
            fallthrough
        case .flexWrap:
            fallthrough
        case .alignSelf:
            fallthrough
        case .alignContent:
            fallthrough
        case .alignItems:
            return 30.0
        case .max:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .padding:
            return 110
        default:
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .addNode:
            break
        case .flexDirection:
            didTapFlexDirection()
        case .justifyContent:
            didTapJustifyContent()
        case .alignItems:
            didTapAlighItems()
        case .alignSelf:
            didTapAlighSelf()
        case .alignContent:
            didTapAlignContent()
        case .flexWrap:
            didTapFlexWrap()
        case .padding:
            break
        case .max:
            fatalError()
        }
    }
}

extension LayoutViewController {
    private func didTapFlexDirection() {
        let indexPath = IndexPath(row: 0, section: Sections.flexDirection.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Flex Direction", message: nil, preferredStyle: .actionSheet)
        let allValues = YGFlexDirection.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.flexDirection = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didTapJustifyContent() {
        let indexPath = IndexPath(row: 0, section: Sections.justifyContent.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Justify Content", message: nil, preferredStyle: .actionSheet)
        let allValues = YGJustify.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.justifyContent = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didTapAlighItems() {
        let indexPath = IndexPath(row: 0, section: Sections.alignItems.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Align Items", message: nil, preferredStyle: .actionSheet)
        let allValues = YGAlign.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.alignItems = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didTapAlignContent() {
        let indexPath = IndexPath(row: 0, section: Sections.alignContent.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Align Content", message: nil, preferredStyle: .actionSheet)
        let allValues = YGAlign.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.alignContent = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didTapAlighSelf() {
        let indexPath = IndexPath(row: 0, section: Sections.alignSelf.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Align Self", message: nil, preferredStyle: .actionSheet)
        let allValues = YGAlign.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.alignSelf = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didTapFlexWrap() {
        let indexPath = IndexPath(row: 0, section: Sections.flexWrap.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Flex Wrap", message: nil, preferredStyle: .actionSheet)
        let allValues = YGWrap.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.flexWrap = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
    private func didPaddingChanged(sender: UITextField, direction: Direction) {
        
    }
}

extension LayoutViewController: AddNodeCellProtocol {
    func onAddChildNode(sender: AddNodeTableViewCell, target: UIButton) {
        delegate?.onTapAddSubView(sender: self)
    }
    
    func onRemoveNode(sender: AddNodeTableViewCell, target: UIButton) {
        
    }
}
