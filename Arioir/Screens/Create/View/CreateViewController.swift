//
//  CreateViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 25.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class CreateViewController: UIViewController {
    
    var viewModel: CreateViewModelType?
    
    
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
        viewModel = CreateViewModel()
        setupUI()
        
    }
    
    fileprivate func setupUI() {
        
        
        view.backgroundColor = .white
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
        viewModel.tableView.createDelegate = self
        
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name:  UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
    }
    
    
    
    
    //MARK: - keyboard functions
    @objc func keyboardWillShow(notification: NSNotification) {
        print(#function)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            guard let viewModel = viewModel else { return }
            var frame = viewModel.tableView.frame
            frame.origin.y = frame.origin.y - keyboardSize.height + 167
            UIView.animate(withDuration: 0.5) {
                self.viewModel!.tableView.frame = frame
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print(#function)
        UIView.animate(withDuration: 0.5) {
            self.viewModel!.tableView.frame.origin.y = 0
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        //        self.dismiss(animated: true, completion: nil)
    }
}



//MARK: - CreateTableViewDelegate
extension CreateViewController: CreateTableViewDelegate {
    func showError(title: String) {
        let toast = ToastViewController(title: title)
        self.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
    
    func deinitView() {
        self.dismiss(animated: true, completion: nil)
    }
}

