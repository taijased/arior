//
//  CardTableViewCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol CardTableViewCellViewModelType: class {
    var name: String { get }
    var value: String { get}
}


class CardTableViewCellViewModel: CardTableViewCellViewModelType {
    
    private var param: FilterParam
    
    var name: String {
        return param.name ?? ""
    }
    
    var value: String {
        return param.value ?? ""
    }

    init(param: FilterParam) {
        self.param = param
    }

    
}
