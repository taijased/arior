//
//  FavoriteCollectionHeaderViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit




class FavoriteCollectionHeaderViewCell: UICollectionViewCell {
    
    static let reuseId = "FavoriteCollectionHeaderViewCell"

    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
  
    fileprivate let label: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Избранное"
        label.textAlignment = .left
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        addSubview(cardView)
        cardView.fillSuperview()
        
        cardView.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
             
       
        cardView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
