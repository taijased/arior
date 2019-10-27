//
//  CreateTableButtonCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit



class CreateTableButtonCell: UITableViewCell {
    
    static let reuseId = "CreateTableButtonCell"
    
    let button: UIButton = {
        let button = UIButton.getCustomButton(label: "Создать проект")
        button.backgroundColor = primaryColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
        
        addSubview(button)
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
