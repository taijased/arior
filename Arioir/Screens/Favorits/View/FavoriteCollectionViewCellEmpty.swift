//
//  FavoriteCollectionViewCellEmpty.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit




class FavoriteCollectionViewHeaderCell: UICollectionViewCell {
    
    static let reuseId = "FavoriteCollectionViewHeaderCell"
    static let height: CGFloat = 40
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
  
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = label.font.withSize(26)
        label.font = label.font.withSize(26)
        label.text = ""
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        addSubview(cardView)
        cardView.fillSuperview()
       
        cardView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding).isActive = true
        label.heightAnchor.constraint(equalToConstant: FavoriteCollectionViewHeaderCell.height).isActive = true
        
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
