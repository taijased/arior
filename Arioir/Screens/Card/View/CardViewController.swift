//
//  CardViewController.swift
//  ARI_UI
//
//  Created by Maxim Spiridonov on 30/07/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate: class {
    func deinitController()
}


class CardViewController: UIViewController {
    
    weak var delegate: CardViewControllerDelegate?
    var viewModel: CardViewModelType?
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        viewModel?.onNavigation = { [weak self] type in
            self?.navigation(type: type)
        }
        
        guard let viewModel = viewModel else { return }
        
       
        view.addSubview(cardView)
        cardView.fillSuperview()
        
        
        cardView.addSubview(viewModel.cardTableView)
        viewModel.cardTableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        viewModel.cardTableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        viewModel.cardTableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        viewModel.cardTableView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        
        view.addSubview(viewModel.cardVCBottomControls)
        viewModel.cardVCBottomControls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.cardVCBottomControls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.cardVCBottomControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.cardVCBottomControls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
               
        
    }
    
    fileprivate func navigation(type: CardModel) {
        switch type {
        case .openAR:
            let viewController = ARPreviewViewController()
            viewController.item = viewModel?.cardTableView.viewModel?.getItem()
            viewController.delegate = self
            viewController.modalPresentationStyle = .fullScreen

            
            //ToDo: - ОСТОРОЖНО ГОВНО КОД
            // эту хуету надо исправить
            let image = WebImageView()
            image.set(imageURL: viewController.item?.picture)
            
            let vo = WallPaperPreview(sceneView: viewController.arView.sceneView,
                                      planeDetector: viewController.arFacade.planeDetector,
                                      image: image.image!,
                                      textureLength: 1.2,
                                      textureWidth: 0.8)
            viewController.arFacade.previewEntitie = vo
            
            
            self.present(viewController, animated: true, completion: nil)
            
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
}


//MARK: - ARPreviewViewControllerDelegate

extension CardViewController: ARPreviewViewControllerDelegate {
    func deinitController() {
        self.dismiss(animated: true, completion: nil)
    }
}
