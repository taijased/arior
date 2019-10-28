//
//  OrderTableView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol OrderTableViewDelegate: class {
    func deinitView()
    func showError(title: String)
}


class OrderTableView: UITableView {
    
    
    
    var viewModel: OrderTableViewViewModelType?
    weak var createDelegate: OrderTableViewDelegate?
    
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(OrderTableHeaderViewCell.self, forCellReuseIdentifier: OrderTableHeaderViewCell.reuseId)
        register(OrderTableFIOViewCell.self, forCellReuseIdentifier: OrderTableFIOViewCell.reuseId)
        register(OrderTableEmailViewCell.self, forCellReuseIdentifier: OrderTableEmailViewCell.reuseId)
        register(OrderTablePhoneViewCell.self, forCellReuseIdentifier: OrderTablePhoneViewCell.reuseId)
        register(OrderTableCommentsViewCell.self, forCellReuseIdentifier: OrderTableCommentsViewCell.reuseId)
        register(OrderTableAddressViewCell.self, forCellReuseIdentifier: OrderTableAddressViewCell.reuseId)
        register(OrderTableDeliveryViewCell.self, forCellReuseIdentifier: OrderTableDeliveryViewCell.reuseId)
        register(OrderTablePaymentViewCell.self, forCellReuseIdentifier: OrderTablePaymentViewCell.reuseId)
        register(OrderTablePrivacyPolicyViewCell.self, forCellReuseIdentifier: OrderTablePrivacyPolicyViewCell.reuseId)
        
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
        allowsSelection = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension OrderTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: OrderTableHeaderViewCell.reuseId, for: indexPath) as? OrderTableHeaderViewCell
            guard let headerCell = cell, let price = viewModel?.price  else { return UITableViewCell() }
            headerCell.set(count: price)
            return headerCell
        case 1:
            let cell = dequeueReusableCell(withIdentifier: OrderTableFIOViewCell.reuseId, for: indexPath) as? OrderTableFIOViewCell
            guard let fioCell = cell else { return UITableViewCell() }
            
            return fioCell
        case 2:
            let cell = dequeueReusableCell(withIdentifier: OrderTableEmailViewCell.reuseId, for: indexPath) as? OrderTableEmailViewCell
            guard let emailCell = cell else { return UITableViewCell() }
            return emailCell
        case 3:
            let cell = dequeueReusableCell(withIdentifier: OrderTablePhoneViewCell.reuseId, for: indexPath) as? OrderTablePhoneViewCell
            guard let phoneCell = cell else { return UITableViewCell() }
            return phoneCell
        case 4:
            let cell = dequeueReusableCell(withIdentifier: OrderTableCommentsViewCell.reuseId, for: indexPath) as? OrderTableCommentsViewCell
            guard let commentCell = cell else { return UITableViewCell() }
            return commentCell
        case 5:
            let cell = dequeueReusableCell(withIdentifier: OrderTableAddressViewCell.reuseId, for: indexPath) as? OrderTableAddressViewCell
            guard let addressCell = cell else { return UITableViewCell() }
            return addressCell
        case 6:
            let cell = dequeueReusableCell(withIdentifier: OrderTableDeliveryViewCell.reuseId, for: indexPath) as? OrderTableDeliveryViewCell
            guard let deliveryCell = cell else { return UITableViewCell() }
            deliveryCell.delegate = self
            return deliveryCell
        case 7:
            let cell = dequeueReusableCell(withIdentifier: OrderTablePaymentViewCell.reuseId, for: indexPath) as? OrderTablePaymentViewCell
            guard let paymentCell = cell else { return UITableViewCell() }
            paymentCell.delegate = self
            return paymentCell
        case 8:
            let cell = dequeueReusableCell(withIdentifier: OrderTablePrivacyPolicyViewCell.reuseId, for: indexPath) as? OrderTablePrivacyPolicyViewCell
            guard let privacypolicyCell = cell else { return UITableViewCell() }
            return privacypolicyCell
        default:
            return  UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
}



//MARK: - OrderTableDeliveryViewCellDelegate, OrderTablePaymentViewCellDelegate

extension OrderTableView: OrderTableDeliveryViewCellDelegate, OrderTablePaymentViewCellDelegate {
    func resultForm(type: OrderModel, _ result: String) {
        switch type {
        case .fio:
            print(type)
        case .email:
            print(type)
        case .phone:
            print(type)
        case .comments:
            print(type)
        case .address:
            print(type)
        case .delivery:
            print(result)
        case .payment:
            print(result)
        }
    }
}
