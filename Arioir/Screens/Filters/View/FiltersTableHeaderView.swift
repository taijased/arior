//
//  FiltersTableHeaderViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import TTRangeSlider



class FiltersTableHeaderView: UIView {
    
    
    static let height: CGFloat = 80
    
    
    let headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Фильтр"
        label.textAlignment = .left
        return label
    }()
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Black.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        setupConstrints()
    }
    
    
    fileprivate func setupConstrints() {
        
        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: Constants.padding).isActive = true

        
        
    }
    
    @objc func rangeSliderValueChanged() {
        
        print("solo")
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
