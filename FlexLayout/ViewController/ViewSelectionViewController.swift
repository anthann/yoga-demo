//
//  ViewSelectionViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/4.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import SnapKit

class ViewSelectionViewController: UIViewController {
    var candidates: [ViewCandidateModel]?
    var completeBlock: ((Int) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CandidateCollectionViewCell.self, forCellWithReuseIdentifier: "candidate cell")
        return collectionView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.preferredContentSize = CGSize(width: 300.0, height: 600.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let candidates = self.candidates else {
            return 0
        }
        return candidates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let candidates = self.candidates else {
            fatalError()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "candidate cell", for: indexPath) as! CandidateCollectionViewCell
        cell.model = candidates[indexPath.item]
        return cell
    }
}

extension ViewSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.completeBlock?(indexPath.item)
        }
    }
}
