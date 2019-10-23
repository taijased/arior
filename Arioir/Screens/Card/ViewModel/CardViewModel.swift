//
//  CardViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit




protocol CardViewModelType {
    var cardTableView: CardTableView { get }
    var cardVCBottomControls: CardVCBottomControls { get }
    func setItem(item: Goods)
    var onNavigation: ((CardModel) -> Void)? { get set }
}

class CardViewModel: CardViewModelType {
    var onNavigation: ((CardModel) -> Void)?
    var cardTableView: CardTableView
    var cardVCBottomControls: CardVCBottomControls
    
    init() {
        cardTableView = CardTableView()
        cardVCBottomControls = CardVCBottomControls()
        cardVCBottomControls.delegate = self

    }
    fileprivate func setupTable() {
 
    }
    
    func setItem(item: Goods) {
        cardTableView.viewModel?.setItem(item: item)
        cardTableView.reloadData()
    }
    
}


//MARK: - CardVCBottomControlsDelegate

extension CardViewModel: CardVCBottomControlsDelegate {
    func openAR() {
        print(#function)
        self.onNavigation?(CardModel.openAR)
    }

    func toOrder() {
        print(#function)
        self.onNavigation?(CardModel.dismiss)
    }

    func addProject() {
        print(#function)
        self.onNavigation?(CardModel.dismiss)
    }
}
