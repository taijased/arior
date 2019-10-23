//
//  BasketTableViewHeaderCell.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 17.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

struct BasketTVDeliveryCellModel {
    var name: String
    var price: String
    var count: Int
}


class BasketTableViewHeaderCell: UITableViewCell {
    
    static let reuseId: String = "BasketTableViewHeaderCell"
    static let height: CGFloat = 120
    
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(26)
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "5 позиций в корзине"
        return label
    }()
    
    let logoView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "shape")
        return imageView
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.font = UIFont(name: "TTNorms-Medium", size: 16)
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Доставка ARI"
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.font = UIFont(name: "TTNorms-Medium", size: 16)
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "2 000 ₽"
        return label
    }()
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    let deliveryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        setupMainLabel()
        setupDeliveryView()
    }
    
    
    
    fileprivate func setupMainLabel() {
        
        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        
        addSubview(countLabel)
        countLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 22).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 31).isActive = true
        

    }
    
    fileprivate func setupDeliveryView() {
        addSubview(deliveryView)
        
        deliveryView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        deliveryView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        deliveryView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        deliveryView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        deliveryView.addSubview(logoView)
        logoView.leadingAnchor.constraint(equalTo: deliveryView.leadingAnchor, constant: Constants.padding).isActive = true
        logoView.centerYAnchor.constraint(equalTo: deliveryView.centerYAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        deliveryView.addSubview(labelName)
        labelName.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: Constants.padding).isActive = true
        labelName.centerYAnchor.constraint(equalTo: deliveryView.centerYAnchor).isActive = true
        
        
        deliveryView.addSubview(labelPrice)
        labelPrice.trailingAnchor.constraint(equalTo: deliveryView.trailingAnchor, constant: -Constants.padding).isActive = true
        labelPrice.centerYAnchor.constraint(equalTo: deliveryView.centerYAnchor).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func set(viewModel: BasketTVDeliveryCellModel) {
        DispatchQueue.main.async {
            self.labelName.text = viewModel.name
            self.labelPrice.text = viewModel.price
            self.countLabel.text = "\(viewModel.count) позиций в корзине"
        }
    }
    
}

