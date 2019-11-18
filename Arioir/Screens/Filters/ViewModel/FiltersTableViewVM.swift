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
    func setHeightForRowAt(_ value: CGFloat)
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FiltersTableViewCellVMType?
    var onReloadData: (() -> Void)? { get set }
    var onDeleteRows: (([IndexPath]) -> Void)? { get set }
    var onInsertRows: (([IndexPath]) -> Void)? { get set }
    func isExpanded(_ section: Int) -> Bool
    func expandSection(_ section: Int)
    func generateSectionView(_ section: Int) -> FiltersTableViewSectionHeader
    var headerView: FiltersTableHeaderView { get set }
}


class FiltersTableViewVM: FiltersTableViewVMType {
    
    
    var heightForHeaderInSection: CGFloat = 36
    var heightRow: CGFloat = 0
    
      
    var cells = [
        ExpandableNames(isExpanded: true, sectionLabel: "Цена (₽)", names: ["Carl"]),
        ExpandableNames(isExpanded: true, sectionLabel: "Длина (м)", names: ["David"]),
        ExpandableNames(isExpanded: true, sectionLabel: "Ширина (м)", names: ["Patrick"]),
    ]
    
    
    var onReloadData: (() -> Void)?
    var onDeleteRows: (([IndexPath]) -> Void)?
    var onInsertRows: (([IndexPath]) -> Void)?
    var headerView: FiltersTableHeaderView
    
    
    init() {
        headerView = FiltersTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: FiltersTableHeaderView.height))
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

    func setHeightForRowAt(_ value: CGFloat) {
        self.heightRow = value
    }
    
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return self.heightRow
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
    

  
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FiltersTableViewCellVMType? {
        let name = cells[indexPath.section].sectionLabel
        return FiltersTableViewCellVM(name: name)
    }
    
    
    func generateSectionView(_ section: Int) -> FiltersTableViewSectionHeader {
        let sectionView = FiltersTableViewSectionHeader()
        sectionView.expandButton.tag = section
        sectionView.updateButton(expandStatus: isExpanded(section))
        sectionView.label.text = cells[section].sectionLabel
        return sectionView
    }
    
    
}
