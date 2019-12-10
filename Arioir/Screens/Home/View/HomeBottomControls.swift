//
//  HomeBottomControls.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 13.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol HomeBottomControlsDelegate: class {
    func onTappedFilter()
    func onTappedFavorites()
    func onTappedCart()
}

class HomeBottomControls: UIView {
    
    weak var delegate: HomeBottomControlsDelegate?
    
    let filterButton: UIButton = {
        var button = UIButton.getCustomButton(imageName: "filter")
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.Yellow.primary
        return button
    }()
    
    @objc func filterTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.onTappedFilter()
        
    }
    
    
    let favoritesButton = ButtonWithBadge(iconName: "favorites")
    let cartButton = ButtonWithBadge(iconName: "cart")
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        
        addSubview(filterButton)
        filterButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        filterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        
        
        addSubview(cartButton)
        
        
        cartButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        cartButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        cartButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        cartButton.onSelectButton = { [weak self] in
            self?.delegate?.onTappedCart()
        }
        
        addSubview(favoritesButton)
        
        favoritesButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -20).isActive = true
        favoritesButton.widthAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        favoritesButton.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        favoritesButton.onSelectButton = { [weak self] in
            self?.delegate?.onTappedFavorites()
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
