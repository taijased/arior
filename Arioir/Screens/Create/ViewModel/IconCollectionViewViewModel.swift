//
//  IconCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol IconCollectionViewViewModelType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> IconCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> String?
    func selectItem(atIndexPath indexPath: IndexPath)
}


class IconCollectionViewViewModel: IconCollectionViewViewModelType {
    
    private var selectedIndexPath: IndexPath?
    var cells: [(name: String, selected: Bool)] = [
        ("room", false),
        ("babyroom", false),
        ("bathroom", false),
        ("toilet", false),
        ("eat-room", false),
        ("kitchen", false),
        ("hall", false),
        ("bedroom", false),
    ]
    
    
    var minimumInteritemSpacingForSectionAt: CGFloat = Constants.padding
    
    var minimumLineSpacingForSectionAt: CGFloat = Constants.padding
    
    func sizeForItemAt() -> CGSize {
        return CGSize(width: 44, height: 44)
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> IconCollectionViewCellViewModelType? {
        let cell = cells[indexPath.row]
        return IconCollectionViewCellViewModel(cell: cell)
    }
    
    func viewModelForSelectedRow() -> String? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return cells[selectedIndexPath.row].name
    }
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        
        for (index, _) in self.cells.enumerated() {
            self.cells[index].selected = false
        }
        self.cells[indexPath.row].selected = true
        self.selectedIndexPath = indexPath
    }
    
    

}
