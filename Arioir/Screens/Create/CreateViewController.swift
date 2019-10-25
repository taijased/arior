//
//  CreateViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 25.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class CreateViewController: UIViewController {
    
    
    fileprivate var button: UIButton = {
       let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
       button.backgroundColor = primaryColor
       button.layer.shadowColor = UIColor.black.cgColor
       button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       button.layer.shadowRadius = 1.0
       button.layer.shadowOpacity = 0.5
       button.layer.cornerRadius = 20
       button.layer.masksToBounds = false
       return button
    }()
    
    @objc fileprivate func buttonTapped(_ sender: UIButton) {
        sender.flash()
        
        print(#function)
    }
    
    
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
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true

    }
    

}


//MARK: - UIViewControllerTransitioningDelegate

extension CreateViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentController = PresentationViewController(presentedViewController: presented, presenting: presenting)
        presentController.closeDelegate = self
        
        return presentController
    }
}

//MARK: - PresentationViewControllerDelegate
extension CreateViewController: PresentationViewControllerDelegate {
    func close() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
}

