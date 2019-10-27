//
//  PresentationController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 25.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    private var calculatedFrameOfPresentedViewInContainerView = CGRect.zero
    private var shouldSetFrameWhenAccessingPresentedView = false

    override var presentedView: UIView? {
        if shouldSetFrameWhenAccessingPresentedView {
            super.presentedView?.frame = calculatedFrameOfPresentedViewInContainerView
        }

        return super.presentedView
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        shouldSetFrameWhenAccessingPresentedView = completed
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        shouldSetFrameWhenAccessingPresentedView = false
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        calculatedFrameOfPresentedViewInContainerView = frameOfPresentedViewInContainerView
    }
}
