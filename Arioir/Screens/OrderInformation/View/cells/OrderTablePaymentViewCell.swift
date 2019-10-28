//
//  OrderTablePaymentViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



protocol OrderTablePaymentViewCellDelegate: class {
    func resultForm(type: OrderModel, _ result: String)
}



class OrderTablePaymentViewCell: UITableViewCell {
    
    static let reuseId = "OrderTablePaymentViewCell"
    weak var delegate: OrderTablePaymentViewCellDelegate?
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.textAlignment = .left
        label.text = "Оплата"
        return label
    }()
    
    let segmentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = primaryColor
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Курьеру", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "В приложении", at: 1, animated: true)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlChenge(_:)), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.selectedSegmentTintColor = primaryColor
        segmentedControl.layer.borderColor = primaryColor!.cgColor
        return segmentedControl
    }()
    
    @objc func segmentControlChenge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            delegate?.resultForm(type: .delivery, "Курьеру")
        case 1:
            delegate?.resultForm(type: .delivery, "В приложении")
        default:
            break
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding + 6).isActive = true
        
        
        
        addSubview(segmentControl)
        segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


