//
//  OrderTableCommentsViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


class CommentsTextField: CustomTextField {
    
    override var textFieldLabel: String {
        get {
            return "Комментарий к заказу"
        }
    }

    
    
//    override func validTextField(_ textFieldText: String) -> Bool {
//        self.errorText = "Неверный формат"
//        return textFieldText.isPhoneNumber
//    }
}


class OrderTableCommentsViewCell: UITableViewCell {
    
    static let reuseId = "OrderTableCommentsViewCell"
    
    var textField: CommentsTextField
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = CommentsTextField()
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
