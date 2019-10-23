//
//  BasketViewModel.swift
//  ARI_UI
//
//  Created by Maxim Spiridonov on 31/07/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation

class BasketViewModel {
    
    let basketTableView = BasketTableView()
    let controlsView: BasketViewControls
    
    
    init() {
        controlsView = BasketViewControls()
        basketTableView.basketDelegate = self
       
    }
}




//MARK: - BasketTableViewDelegate

extension BasketViewModel: BasketTableViewDelegate {
    func onReloadedData() {
        controlsView.updateLabel(count: basketTableView.getAllItemPrices())
    }
}
