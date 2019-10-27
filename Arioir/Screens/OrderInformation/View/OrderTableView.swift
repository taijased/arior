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
        default:
            return  UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }

}

