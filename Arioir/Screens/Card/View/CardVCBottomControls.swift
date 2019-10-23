//
//  CardVCBottomControls.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.


import UIKit


protocol CardVCBottomControlsDelegate: class {
    func openAR()
    func toOrder()
    func addProject()
}

class CardVCBottomControls: UIView {
    
    weak var delegate: CardVCBottomControlsDelegate?
    
    let arButton: UIButton = {
        var button = UIButton.getCustomtButton(imageName: "shape")
        button.addTarget(self, action: #selector(arButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    let addProjectButton: UIButton = {
        var button = UIButton.getCustomtButton(imageName: "plus-yellow")
        button.addTarget(self, action: #selector(addProjectButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.tintColor = .random()
        return button
    }()
    
    let toOrderButton: UIButton = {
        let button = UIButton.getCustomtButton(label: "Добавить в корзину")
        button.addTarget(self, action: #selector(toOrderButtonTapped), for: .touchUpInside)
        button.backgroundColor = primaryColor
        return button
    }()
    
    @objc func addProjectButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.addProject()
    }
    
    @objc func arButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.openAR()
    }
    
    @objc func toOrderButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.toOrder()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        
        addSubview(arButton)
        arButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        arButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        arButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        arButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        
        addSubview(addProjectButton)
        addProjectButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addProjectButton.leadingAnchor.constraint(equalTo: arButton.trailingAnchor, constant: Constants.padding).isActive = true
        addProjectButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        addProjectButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        
        addSubview(toOrderButton)
        toOrderButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toOrderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        toOrderButton.leadingAnchor.constraint(equalTo: addProjectButton.trailingAnchor, constant: Constants.padding).isActive = true
        toOrderButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
