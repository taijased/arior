//
//  ButtonWithBadge.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

class ButtonWithBadge: UIView {
    
    
    var onSelectButton: (() -> Void)?
    
    fileprivate var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.Yellow.primary
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        return button
    }()
    
    
    fileprivate let badge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        label.font = UIFont(name: "TTNorms-Medium", size: 10)
        label.font = label.font.withSize(10)
//        label.text = "4"
        return label
    }()
    
    fileprivate let badgeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Red.primary
        view.layer.cornerRadius = 7.5
        return view
    }()
    
    
    @objc fileprivate func buttonTapped(_ sender: UIButton) {
        sender.flash()
        self.onSelectButton?()
    }
    
    init(iconName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        self.button.setImage(UIImage(named: iconName), for: .normal)
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    fileprivate func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.fillSuperview()
        
        
        addSubview(badgeView)
        badgeView.topAnchor.constraint(equalTo: topAnchor, constant: -2.5).isActive = true
        badgeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2.5).isActive = true
        badgeView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        badgeView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        badgeView.addSubview(badge)
        badge.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor).isActive = true
        badge.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor).isActive = true
        badge.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    
    func updateLabel(newValue: String) {
        self.badge.text = newValue
    }
    
    
}
