//
//  BasketCellControls.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 18.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import UIKit





protocol BasketCellControlsDelegate: class {
    func getCount(_ count: Int)
    func trash()
}



class BasketCellControls: UIView {
    
    weak var delegate: BasketCellControlsDelegate?
    var count: Int = 1
    
    let plusButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.Yellow.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cell-plus"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let minusButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.Yellow.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cell-minus"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let deleteButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.Red.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cell-trush"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    let countLabel: UILabel = {
        let label = UILabel.H4.medium
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        sender.flash()
        count += 1
        updateLabel()
        delegate?.getCount(count)
    }
    
    @objc func minusButtonTapped(_ sender: UIButton) {
        sender.flash()
        if count != 1 {
            count -= 1
            updateLabel()
            delegate?.getCount(count)
        } else {
            return
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.trash()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setupButtonConstraint()

        
        addSubview(countLabel)
        countLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor).isActive = true
        updateLabel()
        
    }
    
    func updateLabel() {
        DispatchQueue.main.async {
            self.countLabel.text = "\(self.count)"
        }
    }
    
    fileprivate func setupButtonConstraint() {
        addSubview(minusButton)
        minusButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        minusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        
        addSubview(plusButton)
        plusButton.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 45).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 32).isActive = true


        
        addSubview(deleteButton)
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
