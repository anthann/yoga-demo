//
//  LayoutViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit

protocol LayoutViewControllerProtocol: AnyObject {
    func onTapAddSubView(sender: LayoutViewController)
    func setNeedsLayoutComponent(sender: LayoutViewController)
}

class LayoutViewController: UIViewController {
    enum Sections: Int {
        case addNode = 0
        case flexDirection
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
        case .max:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Sections(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .addNode:
            return CGFloat.leastNormalMagnitude
        case .flexDirection:
            return 30.0
        case .max:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
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
        self.present(ac, animated: true, completion: nil)
    }
}

extension LayoutViewController: AddNodeCellProtocol {
    func onAddChildNode(sender: AddNodeTableViewCell, target: UIButton) {
        delegate?.onTapAddSubView(sender: self)
    }
    
    func onRemoveNode(sender: AddNodeTableViewCell, target: UIButton) {
        
    }
}
