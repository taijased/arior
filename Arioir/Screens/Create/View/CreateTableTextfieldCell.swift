//
//  CreateTableTextfieldCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 26.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit


class CreateTableTextfieldCell: UITableViewCell {

    static let reuseId = "CreateTableTextfieldCell"
    
  
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.font = UIFont.getTTNormsFont(type: TTNorms.bold, size: 26)
//        textField.addTarget(self, action: #selector(textFieldDidBegin(_:)), for: .editingDidBegin)
//        textField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        textField.returnKeyType = .done
        textField.placeholder = "Введите название проекта"
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
        addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

