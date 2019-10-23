//
//  CardTableViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol CardTableViewViewModelType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRows() -> Int
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CardTableViewCellViewModelType?
    func cellHeader() -> CardTableHeaderCellViewModelType?
    func setItem(item: Goods)
    var onReloadData: (() -> Void)? { get set }
    
}


class CardTableViewViewModel: CardTableViewViewModelType {
 
    
    var onReloadData: (() -> Void)?

    var item: Goods?
    
    
    init() {
    
    }
    
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return item?.params.count ?? 1
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? CardTableHeaderCell.height : 35.0
    }
    
    
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CardTableViewCellViewModelType? {
        guard let cells = item?.params else { return nil }
        let param = cells[indexPath.row]
        return CardTableViewCellViewModel(param: param)
    }
    
    func cellHeader() -> CardTableHeaderCellViewModelType? {
        guard let item = item else { return nil }
        return CardTableHeaderCellViewModel(item: item)
    }
    
    func setItem(item: Goods) {
        self.item = item
    }
     
}
