//
//  TagCollectionViewVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 17.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit



protocol TagCollectionViewVMType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt(_ indexPath: IndexPath) -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TagCollectionViewCellVMType?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    func getHeightCell() -> CGFloat
}

class TagCollectionViewVM: TagCollectionViewVMType {
    
    
    
    var onReloadData: (() -> Void)?
    var minimumInteritemSpacingForSectionAt: CGFloat = 12.0
    var minimumLineSpacingForSectionAt: CGFloat = 12.0
    var cells: [TagModel]
    
    init(cells: [TagModel]) {
        self.cells = cells
    }
    
    
    func getHeightCell() -> CGFloat  {
        
        var sum: CGFloat = 0
        let n = cells.count
        let w = CGFloat(UIScreen.main.bounds.width)
        
        for i in 1...n {
            let label = UILabel()
            label.font = label.font.withSize(14)
            label.text = cells[i - 1].label
            label.font = UIFont.boldSystemFont(ofSize: 14.0)
            let cWidth = label.intrinsicContentSize.width + 24
            sum += cWidth
        }
        return ((sum + CGFloat((n-1)*12))/w) * 36 + CGFloat((n-1)*12)
        
    }
    
    func sizeForItemAt(_ indexPath: IndexPath) -> CGSize {
        
        
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.text = cells[indexPath.row].label
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        let labelWidth = label.intrinsicContentSize.width + 24

        return CGSize(width: labelWidth, height: 36)
    }
    
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TagCollectionViewCellVMType? {
        let cell = cells[indexPath.row]
        return TagCollectionViewCellVM(tag: cell)
    }
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        cells[indexPath.row].status = !cells[indexPath.row].status
        self.onReloadData?()
    }
    
}
