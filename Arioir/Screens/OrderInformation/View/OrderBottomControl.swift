//
//  OrderBottomControl.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.


import UIKit


protocol OrderBottomControlDelegate: class {
    func toOrder()
}

class OrderBottomControl: UIView {
    
    weak var delegate: OrderBottomControlDelegate?
    
  
    
    let toOrderButton: UIButton = {
        let button = UIButton.getCustomButton(label: "Оформить заказ")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toOrderButtonTapped), for: .touchUpInside)
        button.backgroundColor = primaryColor
        return button
    }()
    

    
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
        
        addSubview(toOrderButton)
        toOrderButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toOrderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        toOrderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        toOrderButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
