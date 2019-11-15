//
//  ProjectSettingsVC.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol ProjectCatalogViewDelegate: class {
    func deinitController()
    func showProjectsScreen()
}


class ProjectCatalogViewController: UIViewController {
    
    weak var delegate: ProjectCatalogViewDelegate?
    var viewModel: CatalogHeaderViewCellVMlType?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        view.backgroundColor = .random()
//        guard let collectionView = viewModel?.collectionView else { return }
//        view.addSubview(collectionView)
//        collectionView.fillSuperview()
            
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
    
}


//MARK: - UIViewControllerTransitioningDelegate

extension ProjectCatalogViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentController = PresentationCatalogViewController(presentedViewController: presented, presenting: presenting)
        presentController.closeDelegate = self
        return presentController
    }
}



//MARK: - UIViewControllerTransitioningDelegate

extension ProjectCatalogViewController: PresentationCatalogViewControllerDelegate {
    func swipeDirection(_ direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
        case .down:
            self.dismiss(animated: true, completion: nil)
        case .up:
            self.dismiss(animated: true, completion: nil)
            delegate?.showProjectsScreen()
        case .left: break
        case .right: break
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }

}
