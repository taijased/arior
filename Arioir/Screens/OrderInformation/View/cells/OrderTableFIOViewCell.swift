//
//  OrderTableFIOViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit






class FIOTextField: CustomTextField {
    
    override var textFieldLabel: String {
        get {
            return "ФИО"
        }
    }
    
    override func validTextField(_ textFieldText: String) -> Bool {
        if textFieldText.count > 6 && textFieldText.count < 64 {
           
            return true
        } else {
            self.errorText = "Неверный формат ФИО"
            return false
        }
    }
}


class OrderTableFIOViewCell: UITableViewCell {
    
    static let reuseId = "OrderTableFIOViewCell"
    
    var textField: CustomTextField
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = FIOTextField()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.textField.textFieldLabel = "ФИО"
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(textField)
        textField.fillSuperview()
        
        textField.onValidText = { fio in
            print(fio)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
