//
//  FiltersTableViewVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol FiltersTableViewVMType {
    var heightForHeaderInSection: CGFloat { get set }
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FiltersTableViewCellVMType?
    var onReloadData: (() -> Void)? { get set }
    var onDeleteRows: (([IndexPath]) -> Void)? { get set }
    var onInsertRows: (([IndexPath]) -> Void)? { get set }
    func isExpanded(_ section: Int) -> Bool
    func expandSection(_ section: Int)
    func generateSectionView(_ section: Int) -> FiltersTableViewSectionHeader
//    func updateSectionView(expandStatus: Bool)
}


class FiltersTableViewVM: FiltersTableViewVMType {
    
    
    var heightForHeaderInSection: CGFloat = 36
    var cells = [
        ExpandableNames(isExpanded: true, names: ["Amy"]),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"]),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"]),
        ExpandableNames(isExpanded: true, names: ["Patrick", "Patty"]),
    ]
    
    
    var onReloadData: (() -> Void)?
    var onDeleteRows: (([IndexPath]) -> Void)?
    var onInsertRows: (([IndexPath]) -> Void)?
    
    
    
    init() {
        self.onReloadData?()
    }
    
    func isExpanded(_ section: Int) -> Bool {
        return cells[section].isExpanded
    }
    
    func expandSection(_ section: Int) {
        
        var indexPaths = [IndexPath]()
        for row in cells[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        cells[section].isExpanded = !cells[section].isExpanded
        
        if !cells[section].isExpanded {
            self.onDeleteRows?(indexPaths)
            
        } else {
            self.onInsertRows?(indexPaths)
            
        }
    }

    
    
    func numberOfSections() -> Int {
        return cells.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        
        if !cells[section].isExpanded {
            return 0
        }
        
        return cells[section].names.count
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? CardTableHeaderCell.height : 35.0
    }
    
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FiltersTableViewCellVMType? {
        let name = cells[indexPath.section].names[0]
        return FiltersTableViewCellVM(name: name)
    }
    
    
    func generateSectionView(_ section: Int) -> FiltersTableViewSectionHeader {
        let sectionView = FiltersTableViewSectionHeader()
        sectionView.expandButton.tag = section
        sectionView.updateButton(expandStatus: isExpanded(section))
        return sectionView
    }
    
    
}
