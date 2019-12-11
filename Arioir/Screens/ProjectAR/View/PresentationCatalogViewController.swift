//
//  PresentationCatalogViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol PresentationCatalogViewControllerDelegate: class {
    func swipeDirection(_ direction: UISwipeGestureRecognizer.Direction)
}


class PresentationCatalogViewController: PresentationController {
    
    weak var closeDelegate: PresentationCatalogViewControllerDelegate?
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
     
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeTappedAction))
        swipeDown.direction = .down
        containerView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeTappedAction))
        swipeUp.direction = .up

        containerView.addGestureRecognizer(swipeUp)
        return containerView.bounds
              .inset(by: UIEdgeInsets(top: containerView.bounds.height * 0.7, left: 0, bottom: 0, right: 0))

    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedView?.layer.cornerRadius = 10
        containerView?.backgroundColor = .clear
        

        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.01)
            }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = .clear
            }, completion: nil)
        }
    }
    
    @objc private func swipeTappedAction(_ gesture: UISwipeGestureRecognizer) {
        self.closeDelegate?.swipeDirection(gesture.direction)
    }
}
