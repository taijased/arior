//
//  FavoriteBottomControls.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol FavoriteBottomControlsDelegate: class {
    func refresh()
    func toOrder()
}

class FavoriteBottomControls: UIView {
    
    weak var delegate: FavoriteBottomControlsDelegate?
    
    let refreshButton: UIButton = {
        var button = UIButton.getCustomButton(imageName: "refresh")
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()

    
    let toOrderButton: UIButton = {
        let button = UIButton.getCustomButton(label: "Сформировать корзину")
        button.addTarget(self, action: #selector(toOrderButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.Yellow.primary
        return button
    }()
    
    @objc func refreshButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.refresh()
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
        
        
        addSubview(refreshButton)
        refreshButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true

        addSubview(toOrderButton)
        toOrderButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toOrderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        toOrderButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: Constants.padding).isActive = true
        toOrderButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
