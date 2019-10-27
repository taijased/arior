//
//  PresentationViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 25.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol PresentationViewControllerDelegate: class {
    func close()
}

class PresentationViewController: PresentationController {
    
    weak var closeDelegate: PresentationViewControllerDelegate?
    let visualEffectView: UIVisualEffectView = {

        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = nil
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
//        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        return containerView.bounds
              .inset(by: UIEdgeInsets(top: containerView.bounds.height * 0.65, left: 0, bottom: 0, right: 0))
//            .inset(by: containerView.safeAreaInsets)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedView?.layer.cornerRadius = 10
        containerView?.backgroundColor = .clear
        containerView?.addSubview(visualEffectView)
        visualEffectView.fillSuperview()

        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                self?.containerView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.01)
            }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = .clear
                 self?.visualEffectView.effect = nil
            }, completion: nil)
        }
    }
    
    @objc private func close() {
        self.closeDelegate?.close()
    }
}
