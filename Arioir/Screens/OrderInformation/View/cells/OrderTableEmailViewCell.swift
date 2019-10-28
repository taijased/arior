//
//  OrderTableEmailViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit






class EmailTextField: CustomTextField {
    
    override var textFieldLabel: String {
        get {
            return "E-mail"
        }
    }

    
    override func validTextField(_ textFieldText: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             
        print(emailPred.evaluate(with: textFieldText))
        if emailPred.evaluate(with: textFieldText) {
            
            return true
        } else {
            self.errorText = "Введите в формате. Пример: name@mail.ru"
            return false
        }
    }
}


class OrderTableEmailViewCell: UITableViewCell {
    
    static let reuseId = "OrderTableEmailViewCell"
    
    var textField: EmailTextField
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = EmailTextField()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(textField)
        textField.fillSuperview()
        
        textField.onValidText = { email in
            print(email)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
