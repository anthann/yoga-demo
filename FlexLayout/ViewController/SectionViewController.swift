//
//  SectionViewController.swift
//  FlexLayout
//
//  Created by anthann on 2019/5/3.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit
import YogaKit

protocol SectionViewControllerProtocol: AnyObject {
    func onSelectionChange(sender: SectionViewController, selected: UIView)
}

class SectionViewController: UIViewController {
    static let PreferedWidth: CGFloat = 500.0
    static let PreferedHeight: CGFloat = 400.0
    
    //MARK: Store
    
    var store: Store<Action, State, Command>!
    
    struct State: StateType {
        var selectedView: UIView?
        var candidateViews: [UIView]?
    }
    
    enum Action: ActionType {
        case onTapComponent(_ component: UIView)
        case onTapOutside
    }
    
    enum Command: CommandType {
    }
    
    lazy var reducer: (State, Action) -> (state: State, command: Command?) = { [weak self] (state: State, action: Action) in
        var state = state
        var command: Command? = nil

        guard let strongSelf = self else {
            return (state, command)
        }
        
        switch action {
        case .onTapComponent(let view):
            if let _ = state.selectedView {
                state.selectedView = nil
                state.candidateViews = nil
            } else if let candidates = state.candidateViews, candidates.contains(view) {
                state.candidateViews = nil
                state.selectedView = view
            } else if state.candidateViews == nil && state.selectedView == nil {
                let stack = strongSelf.hitStack(of: view)
                if stack.count > 1 {
                    state.selectedView = nil
                    state.candidateViews = stack
                } else {
                    state.selectedView = stack.first
                    state.candidateViews = nil
                }
            }
        case .onTapOutside:
            state.selectedView = nil
            state.candidateViews = nil
        }
        return (state, command)
    }
    
    func stateDidChanged(state: State, previousState: State?, command: Command?) {
        if let _ = command {
        }
        if previousState == nil || previousState!.selectedView != state.selectedView {
            if let previousView = previousState?.selectedView {
                previousView.layer.shadowOffset = CGSize(width: 0, height: -3.0)
                previousView.layer.shadowRadius = 3.0
                previousView.layer.shadowColor = nil
                previousView.layer.shadowOpacity = 0.0
            }
            if let selectedView = state.selectedView {
                let color: UIColor = selectedView.backgroundColor ?? .black
                selectedView.layer.shadowRadius = 5.0
                selectedView.layer.shadowOffset = CGSize(width: 0, height: 0)
                selectedView.layer.shadowColor = color.cgColor
                selectedView.layer.shadowOpacity = 1.0
                delegate?.onSelectionChange(sender: self, selected: selectedView)
            } else {
                delegate?.onSelectionChange(sender: self, selected: componentView)
            }
        }
        if previousState == nil || previousState!.candidateViews != state.candidateViews {
            presentViewSelection()
        }
    }
    
    //MARK: Vars
    
    weak var delegate: SectionViewControllerProtocol?
    lazy var componentView: ComponentView = {
        var layout = YGLayoutWapperModel()
        layout.justifyContent = .flexStart
        layout.width = YGValueWrapper.point(Float(SectionViewController.PreferedWidth))
        layout.height = YGValueWrapper.point(Float(SectionViewController.PreferedHeight))
        let view = ComponentView()
        view.delegate = self
        view.layoutModel = layout
        return view
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        store = Store<Action, State, Command>(reducer: reducer, initialState: State(selectedView: nil, candidateViews: nil))
        store.subscribe { [weak self] state, previousState, command in
            self?.stateDidChanged(state: state, previousState: previousState, command: command)
        }
    }
    
    private func setupViews() {
        view.addSubview(componentView)
        componentView.applyLayoutModel()
        componentView.layout()
    }
    
    func addView() {
        var layout = YGLayoutWapperModel()
        layout.width = YGValueWrapper.point(100)
        layout.height = YGValueWrapper.point(100)
        let view = ComponentView()
        view.layoutModel = layout
        view.delegate = self
        if let container = store.state.selectedView {
            container.addSubview(view)
        } else {
            componentView.addSubview(view)
        }
        view.applyLayoutModel()
        componentView.layout()
    }
    
    func removeView(_ view: UIView) {
        if view == componentView {
            return
        }
        view.removeFromSuperview()
        componentView.layout()
        store.dispatch(.onTapOutside)
    }
    
    private func hitStack(of view: UIView) -> [UIView] {
        var result = [UIView]()
        var current: UIView? = view
        while let currentView = current {
            result.append(currentView)
            if currentView == componentView {
                break
            }
            current = currentView.superview
        }
        return result
    }
    
    private func presentViewSelection() {
        guard let candidates = store.state.candidateViews, !candidates.isEmpty else {
            return
        }
        let models: [ViewCandidateModel] = candidates.map { (view) -> ViewCandidateModel in
            let color: UIColor = view.backgroundColor ?? .white
            let model = ViewCandidateModel(colorString: color.hexString(), size: view.bounds.size)
            return model
        }
        let vc = ViewSelectionViewController()
        vc.candidates = models
        vc.completeBlock = { [weak self] index in
            self?.store.dispatch(.onTapComponent(candidates[index]))
        }
        vc.dismissBlock = { [weak self] in
            self?.store.dispatch(.onTapOutside)
        }
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.permittedArrowDirections = .right
        vc.popoverPresentationController?.backgroundColor = .white
        vc.popoverPresentationController?.sourceView = candidates.first
        vc.popoverPresentationController?.sourceRect = candidates.first!.bounds
        self.present(vc, animated: true, completion: nil)
    }
}

extension SectionViewController: ComponentHolderProtocol {
    func onTapComponent(sender: UIView) {
        store.dispatch(.onTapComponent(sender))
    }
}
