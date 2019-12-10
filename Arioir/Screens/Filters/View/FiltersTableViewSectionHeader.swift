//
//  FiltersTableViewSectionHeader.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class FiltersTableViewSectionHeader: UIView {
    
    
    let label: UILabel = {
        let label = UILabel.H4.medium
        label.textAlignment = .left
        label.text = "Цена (₽)"
        return label
    }()
    
    fileprivate let sectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let expandButton: UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        //        button.setImage(UIImage(named: "arrow-down"), for: .normal)
        //        button.setImage(UIImage(named: "arrow-top"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        addSubview(sectionView)
        sectionView.fillSuperview()
        
        
        sectionView.addSubview(label)
        label.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -Constants.padding).isActive = true
        label.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: Constants.padding).isActive = true
        label.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor).isActive = true
        
        
        addSubview(expandButton)
        expandButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        expandButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func updateButton(expandStatus: Bool) {
        
        
        if expandStatus {
            UIView.animate(withDuration: 0.3) {
                self.expandButton.setImage(UIImage(named: "arrow-down"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                
                self.expandButton.setImage(UIImage(named: "arrow-top"), for: .normal)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

