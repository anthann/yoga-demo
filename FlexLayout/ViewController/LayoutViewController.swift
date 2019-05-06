//
//  LayoutViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit
import IHKeyboardAvoiding

protocol LayoutViewControllerProtocol: AnyObject {
    func onTapAddSubView(sender: LayoutViewController)
    func setNeedsLayoutComponent(sender: LayoutViewController)
}

class LayoutViewController: UIViewController {
    enum Sections: Int {
        case addNode = 0
        case direction
        case flexDirection
        case justifyContent
        case alignItems
        case alignSelf
        case alignContent
        case flexWrap
        case positionType
        case size
        case maxSize
        case minSize
        case padding
        case margin
        case position
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
        tableView.register(SizeTableViewCell.self, forCellReuseIdentifier: SizeTableViewCell.ReuseIdentifier)
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
        case .direction:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.direction.title
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
        case .positionType:
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.ReuseIdentifier) as! DropDownTableViewCell
            cell.title = currentTarget?.layoutModel?.position.title
            return cell
        case .padding:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaddingTableViewCell.ReuseIdentifier) as! PaddingTableViewCell
            cell.label.text = "PADDING"
            cell.leftTextField.placeholder = "0"
            cell.rightTextField.placeholder = "0"
            cell.topTextField.placeholder = "0"
            cell.bottomTextField.placeholder = "0"
            cell.leftTextField.delegate = self
            cell.rightTextField.delegate = self
            cell.topTextField.delegate = self
            cell.bottomTextField.delegate = self
            cell.leftTextField.addTarget(self, action: #selector(didPaddingChanged), for: .editingChanged)
            cell.rightTextField.addTarget(self, action: #selector(didPaddingChanged), for: .editingChanged)
            cell.topTextField.addTarget(self, action: #selector(didPaddingChanged), for: .editingChanged)
            cell.bottomTextField.addTarget(self, action: #selector(didPaddingChanged), for: .editingChanged)
            if let left = currentTarget?.layoutModel?.actualPaddingLeft, case YGValueWrapper.point(let value) = left {
                cell.leftTextField.text = String(format: "%.1f", value)
            }
            if let right = currentTarget?.layoutModel?.actualPaddingRight, case YGValueWrapper.point(let value) = right {
                cell.rightTextField.text = String(format: "%.1f", value)
            }
            if let top = currentTarget?.layoutModel?.actualPaddingTop, case YGValueWrapper.point(let value) = top {
                cell.topTextField.text = String(format: "%.1f", value)
            }
            if let bottom = currentTarget?.layoutModel?.actualPaddingBottom, case YGValueWrapper.point(let value) = bottom {
                cell.bottomTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .margin:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaddingTableViewCell.ReuseIdentifier) as! PaddingTableViewCell
            cell.label.text = "MARGIN"
            cell.leftTextField.placeholder = "0"
            cell.rightTextField.placeholder = "0"
            cell.topTextField.placeholder = "0"
            cell.bottomTextField.placeholder = "0"
            cell.leftTextField.delegate = self
            cell.rightTextField.delegate = self
            cell.topTextField.delegate = self
            cell.bottomTextField.delegate = self
            cell.leftTextField.addTarget(self, action: #selector(didMarginChanged(sender:)), for: .editingChanged)
            cell.rightTextField.addTarget(self, action: #selector(didMarginChanged(sender:)), for: .editingChanged)
            cell.topTextField.addTarget(self, action: #selector(didMarginChanged(sender:)), for: .editingChanged)
            cell.bottomTextField.addTarget(self, action: #selector(didMarginChanged(sender:)), for: .editingChanged)
            if let left = currentTarget?.layoutModel?.actualMarginLeft, case YGValueWrapper.point(let value) = left {
                cell.leftTextField.text = String(format: "%.1f", value)
            }
            if let right = currentTarget?.layoutModel?.actualMarginRight, case YGValueWrapper.point(let value) = right {
                cell.rightTextField.text = String(format: "%.1f", value)
            }
            if let top = currentTarget?.layoutModel?.actualMarginTop, case YGValueWrapper.point(let value) = top {
                cell.topTextField.text = String(format: "%.1f", value)
            }
            if let bottom = currentTarget?.layoutModel?.actualMarginBottom, case YGValueWrapper.point(let value) = bottom {
                cell.bottomTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .position:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaddingTableViewCell.ReuseIdentifier) as! PaddingTableViewCell
            cell.label.text = "POSITION"
            cell.leftTextField.placeholder = "0"
            cell.rightTextField.placeholder = "0"
            cell.topTextField.placeholder = "0"
            cell.bottomTextField.placeholder = "0"
            cell.leftTextField.delegate = self
            cell.rightTextField.delegate = self
            cell.topTextField.delegate = self
            cell.bottomTextField.delegate = self
            cell.leftTextField.addTarget(self, action: #selector(didPositionChanged(sender:)), for: .editingChanged)
            cell.rightTextField.addTarget(self, action: #selector(didPositionChanged(sender:)), for: .editingChanged)
            cell.topTextField.addTarget(self, action: #selector(didPositionChanged(sender:)), for: .editingChanged)
            cell.bottomTextField.addTarget(self, action: #selector(didPositionChanged(sender:)), for: .editingChanged)
            if let left = currentTarget?.layoutModel?.left, case YGValueWrapper.point(let value) = left {
                cell.leftTextField.text = String(format: "%.1f", value)
            }
            if let right = currentTarget?.layoutModel?.right, case YGValueWrapper.point(let value) = right {
                cell.rightTextField.text = String(format: "%.1f", value)
            }
            if let top = currentTarget?.layoutModel?.top, case YGValueWrapper.point(let value) = top {
                cell.topTextField.text = String(format: "%.1f", value)
            }
            if let bottom = currentTarget?.layoutModel?.bottom, case YGValueWrapper.point(let value) = bottom {
                cell.bottomTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .size:
            let cell = tableView.dequeueReusableCell(withIdentifier: SizeTableViewCell.ReuseIdentifier) as! SizeTableViewCell
            cell.widthTextField.placeholder = "0"
            cell.heightTextField.placeholder = "0"
            cell.widthTextField.delegate = self
            cell.heightTextField.delegate = self
            cell.widthTextField.addTarget(self, action: #selector(didSizeChanged(sender:)), for: .editingChanged)
            cell.heightTextField.addTarget(self, action: #selector(didSizeChanged(sender:)), for: .editingChanged)
            if let width = currentTarget?.layoutModel?.width, case YGValueWrapper.point(let value) = width {
                cell.widthTextField.text = String(format: "%.1f", value)
            }
            if let height = currentTarget?.layoutModel?.height, case YGValueWrapper.point(let value) = height {
                cell.heightTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .maxSize:
            let cell = tableView.dequeueReusableCell(withIdentifier: SizeTableViewCell.ReuseIdentifier) as! SizeTableViewCell
            cell.widthTextField.placeholder = "0"
            cell.heightTextField.placeholder = "0"
            cell.widthTextField.delegate = self
            cell.heightTextField.delegate = self
            cell.widthTextField.addTarget(self, action: #selector(didMaxSizeChanged(sender:)), for: .editingChanged)
            cell.heightTextField.addTarget(self, action: #selector(didMaxSizeChanged(sender:)), for: .editingChanged)
            if let width = currentTarget?.layoutModel?.maxWidth, case YGValueWrapper.point(let value) = width {
                cell.widthTextField.text = String(format: "%.1f", value)
            }
            if let height = currentTarget?.layoutModel?.maxHeight, case YGValueWrapper.point(let value) = height {
                cell.heightTextField.text = String(format: "%.1f", value)
            }
            return cell
        case .minSize:
            let cell = tableView.dequeueReusableCell(withIdentifier: SizeTableViewCell.ReuseIdentifier) as! SizeTableViewCell
            cell.widthTextField.placeholder = "0"
            cell.heightTextField.placeholder = "0"
            cell.widthTextField.delegate = self
            cell.heightTextField.delegate = self
            cell.widthTextField.addTarget(self, action: #selector(didMinSizeChanged(sender:)), for: .editingChanged)
            cell.heightTextField.addTarget(self, action: #selector(didMinSizeChanged(sender:)), for: .editingChanged)
            if let width = currentTarget?.layoutModel?.minWidth, case YGValueWrapper.point(let value) = width {
                cell.widthTextField.text = String(format: "%.1f", value)
            }
            if let height = currentTarget?.layoutModel?.minHeight, case YGValueWrapper.point(let value) = height {
                cell.heightTextField.text = String(format: "%.1f", value)
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
        case .direction:
            return "DIRECTION"
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
        case .positionType:
            return "POSITION TYPE"
        case .padding:
            return nil
        case .margin:
            return nil
        case .position:
            return nil
        case .size:
            return "WIDTH X HEIGHT"
        case .maxSize:
            return "MAX_WIDTH X MAX_HEIGHT"
        case .minSize:
            return "MIN_WIDTH X MIN_HEIGHT"
        case .max:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Sections(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .position:
            return CGFloat.leastNormalMagnitude
        case .margin:
            return CGFloat.leastNormalMagnitude
        case .padding:
            return CGFloat.leastNormalMagnitude
        case .addNode:
            return CGFloat.leastNormalMagnitude
        case .direction:
            fallthrough
        case .size:
            fallthrough
        case .maxSize:
            fallthrough
        case .minSize:
            fallthrough
        case .flexDirection:
            fallthrough
        case .justifyContent:
            fallthrough
        case .flexWrap:
            fallthrough
        case .positionType:
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
        case .margin:
            fallthrough
        case .position:
            fallthrough
        case .padding:
            return 110
        default:
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .addNode:
            break
        case .direction:
            didTapDirection()
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
        case .positionType:
            didTapPositionType()
        case .padding:
            break
        case .margin:
            break
        case .position:
            break
        case .size:
            break
        case .minSize:
            break
        case .maxSize:
            break
        case .max:
            fatalError()
        }
    }
}

extension LayoutViewController {
    private func didTapDirection() {
        let indexPath = IndexPath(row: 0, section: Sections.direction.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Direction", message: nil, preferredStyle: .actionSheet)
        let allValues = YGDirection.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.direction = value
                strongSelf.currentTarget?.applyLayoutModel()
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.delegate?.setNeedsLayoutComponent(sender: strongSelf)
            }))
        }
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.permittedArrowDirections = .right
        self.present(ac, animated: true, completion: nil)
    }
    
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
    
    private func didTapPositionType() {
        let indexPath = IndexPath(row: 0, section: Sections.positionType.rawValue)
        let cell = tableView.cellForRow(at: indexPath)
        let ac = UIAlertController(title: "Position Type", message: nil, preferredStyle: .actionSheet)
        let allValues = YGPositionType.allValues
        for value in allValues {
            ac.addAction(UIAlertAction(title: value.title, style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.currentTarget?.layoutModel?.position = value
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
    
    @objc func didPaddingChanged(sender: UITextField) {
        guard let direction = Direction(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch direction {
            case .left:
                currentTarget?.layoutModel?.paddingLeft = YGValueWrapper.point(value)
            case .right:
                currentTarget?.layoutModel?.paddingRight = YGValueWrapper.point(value)
            case .top:
                currentTarget?.layoutModel?.paddingTop = YGValueWrapper.point(value)
            case .bottom:
                currentTarget?.layoutModel?.paddingBottom = YGValueWrapper.point(value)
            }
        } else {
            switch direction {
            case .left:
                currentTarget?.layoutModel?.paddingLeft = nil
            case .right:
                currentTarget?.layoutModel?.paddingRight = nil
            case .top:
                currentTarget?.layoutModel?.paddingTop = nil
            case .bottom:
                currentTarget?.layoutModel?.paddingBottom = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
    
    @objc func didMarginChanged(sender: UITextField) {
        guard let direction = Direction(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch direction {
            case .left:
                currentTarget?.layoutModel?.marginLeft = YGValueWrapper.point(value)
            case .right:
                currentTarget?.layoutModel?.marginRight = YGValueWrapper.point(value)
            case .top:
                currentTarget?.layoutModel?.marginTop = YGValueWrapper.point(value)
            case .bottom:
                currentTarget?.layoutModel?.marginBottom = YGValueWrapper.point(value)
            }
        } else {
            switch direction {
            case .left:
                currentTarget?.layoutModel?.marginLeft = nil
            case .right:
                currentTarget?.layoutModel?.marginRight = nil
            case .top:
                currentTarget?.layoutModel?.marginTop = nil
            case .bottom:
                currentTarget?.layoutModel?.marginBottom = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
    
    @objc func didPositionChanged(sender: UITextField) {
        guard let direction = Direction(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch direction {
            case .left:
                currentTarget?.layoutModel?.left = YGValueWrapper.point(value)
            case .right:
                currentTarget?.layoutModel?.right = YGValueWrapper.point(value)
            case .top:
                currentTarget?.layoutModel?.top = YGValueWrapper.point(value)
            case .bottom:
                currentTarget?.layoutModel?.bottom = YGValueWrapper.point(value)
            }
        } else {
            switch direction {
            case .left:
                currentTarget?.layoutModel?.left = nil
            case .right:
                currentTarget?.layoutModel?.right = nil
            case .top:
                currentTarget?.layoutModel?.top = nil
            case .bottom:
                currentTarget?.layoutModel?.bottom = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
    
    @objc func didSizeChanged(sender: UITextField) {
        guard let dimension = SizeDimension(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.width = YGValueWrapper.point(value)
            case .height:
                currentTarget?.layoutModel?.height = YGValueWrapper.point(value)
            }
        } else {
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.width = nil
            case .height:
                currentTarget?.layoutModel?.height = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
    
    @objc func didMaxSizeChanged(sender: UITextField) {
        guard let dimension = SizeDimension(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.maxWidth = YGValueWrapper.point(value)
            case .height:
                currentTarget?.layoutModel?.maxHeight = YGValueWrapper.point(value)
            }
        } else {
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.maxWidth = nil
            case .height:
                currentTarget?.layoutModel?.maxHeight = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
    
    @objc func didMinSizeChanged(sender: UITextField) {
        guard let dimension = SizeDimension(rawValue: sender.tag) else {
            fatalError()
        }
        if let text = sender.text, !text.isEmpty {
            let value: Float = NSString(string: text).floatValue
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.minWidth = YGValueWrapper.point(value)
            case .height:
                currentTarget?.layoutModel?.minHeight = YGValueWrapper.point(value)
            }
        } else {
            switch dimension {
            case .width:
                currentTarget?.layoutModel?.minWidth = nil
            case .height:
                currentTarget?.layoutModel?.minHeight = nil
            }
        }
        currentTarget?.applyLayoutModel()
        delegate?.setNeedsLayoutComponent(sender: self)
    }
}

extension LayoutViewController: AddNodeCellProtocol {
    func onAddChildNode(sender: AddNodeTableViewCell, target: UIButton) {
        delegate?.onTapAddSubView(sender: self)
    }
    
    func onRemoveNode(sender: AddNodeTableViewCell, target: UIButton) {
        
    }
}

extension LayoutViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        KeyboardAvoiding.setAvoidingView(tableView, withTriggerView: textField)
        return true
    }
}
