//
//  BasketViewControls.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 17.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol BasketViewControlsDelegate: class {
    func refresh()
    func toOrder()
}

class BasketViewControls: UIView {
    
    weak var delegate: BasketViewControlsDelegate?
    
    let refreshButton: UIButton = {
        var button = UIButton.getCustomButton(imageName: "refresh")
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    
    let orderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 20
        view.backgroundColor = primaryColor
        return view
    }()
    
    
    let labelOrder: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Оформить заказ"
        return label
    }()
    
    let labelAllPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "0,00 ₽"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupButtons()
        setupLabels()
    }
    
    fileprivate func setupButtons() {
        
        addSubview(refreshButton)
        refreshButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        addSubview(orderView)
        orderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        orderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        orderView.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: Constants.padding).isActive = true
        orderView.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toOrderButtonTapped(recognzier:)))
        orderView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    fileprivate func setupLabels() {
        
        orderView.addSubview(labelOrder)
        labelOrder.centerYAnchor.constraint(equalTo: orderView.centerYAnchor).isActive = true
        labelOrder.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 22).isActive = true
        labelOrder.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        orderView.addSubview(labelAllPrice)
        labelAllPrice.centerYAnchor.constraint(equalTo: orderView.centerYAnchor).isActive = true
        labelAllPrice.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -22).isActive = true
        labelAllPrice.heightAnchor.constraint(equalToConstant: 19).isActive = true
              
    }
    
    func updateLabel(count: Float) {
        DispatchQueue.main.async {
            self.labelAllPrice.text = "\(count) ₽"
        }
    }
    
    
    
    @objc func toOrderButtonTapped(recognzier: UITapGestureRecognizer) {
        delegate?.toOrder()
    }
    
    
    @objc func refreshButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.refresh()
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
