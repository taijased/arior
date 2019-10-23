//
//  CardTableViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

class CardTableViewCell: UITableViewCell {

    static let reuseId = "CardTableViewCell"
    
    
    weak var viewModel: CardTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            labelName.text = viewModel.name
            labelDescription.text = viewModel.value
        }
    }
    
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "TTNorms-Medium", size: 16)
        
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = primaryColorGray
        label.font = UIFont(name: "TTNorms-Medium", size: 14)
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayers()
    }
    
    fileprivate func setupLayers() {
        selectionStyle = .none
        
        addSubview(labelName)
        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        labelName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        addSubview(labelDescription)
        labelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        labelDescription.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelDescription.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
    }
    
    func set(_ viewModel: FilterParam) {
        labelName.text = viewModel.name
        labelDescription.text = viewModel.value
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
