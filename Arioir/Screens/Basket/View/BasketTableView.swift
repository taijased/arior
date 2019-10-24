//
//  BasketTableView.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 17.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift



protocol BasketTableViewDelegate: class {
    func onReloadedData()
}


class BasketTableView: UITableView {
    
    
    weak var basketDelegate: BasketTableViewDelegate?
    
    var cells: Results<BasketItem>!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
        
        
    }
    
    fileprivate func setupUI() {
        cells = realm.objects(BasketItem.self)
        reloadData { [weak self] in
            self?.basketDelegate?.onReloadedData()
        }
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseId)
        register(BasketTableViewHeaderCell.self, forCellReuseIdentifier: BasketTableViewHeaderCell.reuseId)
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
    
    
    func getAllItemPrices() -> Float{
        var sum: Float = 0
        cells.forEach({ (item) in
            sum += item.getAllPrice()
        })
        return sum
    }
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension BasketTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewHeaderCell.reuseId, for: indexPath) as! BasketTableViewHeaderCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseId, for: indexPath) as! BasketTableViewCell
            cell.contentView.backgroundColor = UIColor.clear
            cell.set(cells[indexPath.row - 1])
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return BasketTableViewHeaderCell.height
        default:
            return 100
        }
    }
    
    
}

//MARK: - BasketTableViewCellDelegate

extension BasketTableView: BasketTableViewCellDelegate {
    func onTrashButton(id: String) {
        StorageManager.deleteBasketItem(id) { [weak self] in
            self?.reloadData(completion: { [weak self] in
                self?.basketDelegate?.onReloadedData()
            })
        }
    }
    
    func onChangheInfo() {
        self.reloadData { [weak self] in
            self?.basketDelegate?.onReloadedData()
        }
    }
}


