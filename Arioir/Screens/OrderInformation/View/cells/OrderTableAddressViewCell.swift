//
//  OrderTableAddressViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit


class AddressTextField: CustomTextField {
    
    override var textFieldLabel: String {
        get {
            return "Адрес доставки"
        }
    }

    
    
//    override func validTextField(_ textFieldText: String) -> Bool {
//        self.errorText = "Неверный формат"
//        return textFieldText.isPhoneNumber
//    }
}


class OrderTableAddressViewCell: UITableViewCell {
    
    static let reuseId = "OrderTableAddressViewCell"
    
    var textField: AddressTextField
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = AddressTextField()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(textField)
        textField.fillSuperview()
        
        textField.onValidText = { phone in
            print(phone)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
