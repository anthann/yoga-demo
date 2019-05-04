//
//  LayoutViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/22.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

protocol LayoutViewControllerProtocol: AnyObject {
    func onTapAddSubView(sender: LayoutViewController)
}

class LayoutViewController: UIViewController {
    enum Sections: Int {
        case addNode = 0
        case direction
        case flexDirection
        case basisGrowShrink
        case flwxWrap
        case max
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddNodeTableViewCell.self, forCellReuseIdentifier: AddNodeTableViewCell.ReuseIdentifier)
        return tableView
    }()
    
    weak var delegate: LayoutViewControllerProtocol?
    weak var currentTarget: UIView?
    weak var componentHolderDelegate: ComponentHolderProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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
        default:
            return UITableViewCell()
        }
    }
}

extension LayoutViewController: UITableViewDelegate {
    
}

extension LayoutViewController: AddNodeCellProtocol {
    func onAddChildNode(sender: AddNodeTableViewCell, target: UIButton) {
        delegate?.onTapAddSubView(sender: self)
//        let ac = UIAlertController(title: "Add Child Node", message: nil, preferredStyle: .actionSheet)
//        ac.popoverPresentationController?.sourceView = target
//        ac.popoverPresentationController?.sourceRect = target.bounds
//        ac.addAction(UIAlertAction(title: "View", style: .default, handler: { [weak self] (action) in
//            guard let targetView = self?.currentTarget as? UIView else {
//                return
//            }
//            let view = ComponentView()
//            view.delegate = self
//            targetView.addSubview(view)
//            targetView.yoga.applyLayout(preservingOrigin: true)
//        }))
//        ac.addAction(UIAlertAction(title: "Label", style: .default, handler: { [weak self] (action) in
//            guard let targetView = self?.currentTarget as? UIView else {
//                return
//            }
//            let view = ComponentLabel()
//            view.delegate = self
//            targetView.addSubview(view)
//            targetView.yoga.applyLayout(preservingOrigin: true)
//        }))
//        ac.addAction(UIAlertAction(title: "Button", style: .default, handler: { [weak self] (action) in
//            guard let targetView = self?.currentTarget as? UIView else {
//                return
//            }
//            let view = ComponentButton()
//            view.delegate = self
//            targetView.addSubview(view)
//            targetView.yoga.applyLayout(preservingOrigin: true)
//        }))
//        ac.addAction(UIAlertAction(title: "ImageView", style: .default, handler: { [weak self] (action) in
//            guard let targetView = self?.currentTarget as? UIView else {
//                return
//            }
//            let view = ComponentImageView(frame: .zero)
//            view.delegate = self
//            targetView.addSubview(view)
//            targetView.yoga.applyLayout(preservingOrigin: true)
//        }))
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(ac, animated: true, completion: nil)
    }
    
    func onRemoveNode(sender: AddNodeTableViewCell, target: UIButton) {
        
    }
}

//extension LayoutViewController: ComponentHolderProtocol {
//    func onTapComponent(sender: UIView) {
//        currentTarget = sender
//        componentHolderDelegate?.onTapComponent(sender: sender)
//    }
//}
