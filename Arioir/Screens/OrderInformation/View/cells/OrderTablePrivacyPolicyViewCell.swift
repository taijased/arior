//
//  OrderTablePrivacyPolicyViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//
import UIKit



class OrderTablePrivacyPolicyViewCell: UITableViewCell {
    
    static let reuseId = "OrderTablePrivacyPolicyViewCell"

    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

//        textView.isEditable = false
//        textView.dataDetectorTypes = .link
//
//
        label.font = label.font.withSize(14)
        label.numberOfLines = 0
        label.text = "Отправляя форму вы соглашаетесь на обработку персональных данных, а также подтверждаете, что ознакомлены с условиями возврата товара"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding + 6).isActive = true
    
        let link = "https://arq.su/privacypolicy"
        
        let text = label.text ?? ""
        let firstString = NSAttributedString.makeHyperlink(for: link, in: text, as: "возврата товара")
        label.attributedText = firstString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NSAttributedString {
    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
    }
}
