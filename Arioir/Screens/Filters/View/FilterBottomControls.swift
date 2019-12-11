//
//  FilterBottomControls.swift
//  Arioir
//
//  Created by Максим Спиридонов on 10.12.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol FilterBottomControlsDelegate: class {
    func refresh()
    func toShow()
}

class FilterBottomControls: UIView {
    
    weak var delegate: FilterBottomControlsDelegate?
    
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
        view.backgroundColor = UIColor.Yellow.primary
        return view
    }()
    
    
    let label: UILabel = {
        let label = UILabel.H3.medium
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Показать результаты"
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
        orderView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: orderView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: orderView.centerXAnchor).isActive = true
    }

    
    @objc func toOrderButtonTapped(recognzier: UITapGestureRecognizer) {
        delegate?.toShow()
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
