//
//  OrderTableHeaderViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit



class OrderTableHeaderViewCell: UITableViewCell {
    
    static let reuseId: String = "OrderTableHeaderViewCell"

    
    let labelName: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Итого: "
        label.alpha = 0.3
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel.H1.bold
        label.textAlignment = .right
        return label
    }()
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {

        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        
        addSubview(labelName)
        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        labelName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        addSubview(labelPrice)
        labelPrice.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 6).isActive = true
        labelPrice.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func set(count: String) {
        DispatchQueue.main.async {
            self.labelPrice.text = count + " ₽"
        }
    }
    
}

