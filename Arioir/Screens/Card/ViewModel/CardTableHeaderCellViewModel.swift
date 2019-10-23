//
//  CardTableHeaderCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol CardTableHeaderCellViewModelType: class {
    var name: String { get }
    var imageURL: String { get}
}

class CardTableHeaderCellViewModel: CardTableHeaderCellViewModelType {

    private var item: Goods
    
    var name: String {
        return item.name ?? ""
    }
    var imageURL: String {
        guard let picture = item.picture else { return ""}
        return picture
    }
    
    init(item: Goods) {
        self.item = item
    }
    
    
}
