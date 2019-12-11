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
    func getTappedTag() -> [String: [String]]
}


class FiltersTableViewVM: FiltersTableViewVMType {
    
    
    var heightForHeaderInSection: CGFloat = 36
    var heightRow: CGFloat = 0
    
    
    
    var cells = [
        
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Длина (м)", cells: [
            TagModel(label: "6,60", status: false),
            TagModel(label: "2,95", status: false),
            TagModel(label: "9,38", status: false),
            TagModel(label: "8,23", status: false),
            TagModel(label: "3,00", status: false),
            TagModel(label: "3,30", status: false),
            TagModel(label: "10,05", status: false),
            TagModel(label: "25", status: false),
            TagModel(label: "9,90", status: false),
            TagModel(label: "2,80", status: false),
            TagModel(label: "3,20", status: false),
            TagModel(label: "2,85", status: false),
            TagModel(label: "10,00", status: false),
            TagModel(label: "5,00", status: false),
            TagModel(label: "3,15", status: false),
            TagModel(label: "8,84", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Ширина (см)", cells: [
            TagModel(label: "68,58", status: false),
            TagModel(label: "372", status: false),
            TagModel(label: "186", status: false),
            TagModel(label: "18", status: false),
            TagModel(label: "19,5", status: false),
            TagModel(label: "43", status: false),
            TagModel(label: "35", status: false),
            TagModel(label: "26,5", status: false),
            TagModel(label: "9", status: false),
            TagModel(label: "280", status: false),
            TagModel(label: "200", status: false),
            TagModel(label: "9,4", status: false),
            TagModel(label: "10,5", status: false),
            TagModel(label: "300", status: false),
            TagModel(label: "250", status: false),
            TagModel(label: "52", status: false),
            TagModel(label: "68,5", status: false),
            TagModel(label: "98", status: false),
            TagModel(label: "13,3", status: false),
            TagModel(label: "17,8", status: false),
            TagModel(label: "8,7", status: false),
            TagModel(label: "75", status: false),
            TagModel(label: "104", status: false),
            TagModel(label: "106", status: false),
            TagModel(label: "13", status: false),
            TagModel(label: "53", status: false),
            TagModel(label: "100", status: false),
            TagModel(label: "70", status: false),
            TagModel(label: "26", status: false),
            TagModel(label: "17", status: false),
            TagModel(label: "16", status: false),
            TagModel(label: "25,5", status: false),
            TagModel(label: "17,5", status: false),
            TagModel(label: "2,79", status: false),
            TagModel(label: "136", status: false),
            TagModel(label: "10", status: false),
            TagModel(label: "1,86", status: false),
            TagModel(label: "5", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Покрытие", cells: [
            TagModel(label: "флизелин с акриловым напылением", status: false),
            TagModel(label: "бумага с акрилом", status: false),
            TagModel(label: "лак, акрил", status: false),
            TagModel(label: "тяжелый винил", status: false),
            TagModel(label: "винил с флоком", status: false),
            TagModel(label: "бумага", status: false),
            TagModel(label: "текстиль", status: false),
            TagModel(label: "стеклярус на флизелине", status: false),
            TagModel(label: "флок на флизелине", status: false),
            TagModel(label: "компактный винил", status: false),
            TagModel(label: "винил", status: false),
            TagModel(label: "флизелин", status: false),
            TagModel(label: "винил горячего тиснения", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Основа", cells: [
            TagModel(label: "бумага", status: false),
            TagModel(label: "флизелин", status: false)
        ])),
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Бренд", cells: [
            TagModel(label: "Sangiorgio", status: false),
            TagModel(label: "Marburg", status: false),
            TagModel(label: "BN Wallcoverings", status: false),
            TagModel(label: "Grandeco", status: false),
            TagModel(label: "Rasch", status: false),
            TagModel(label: "Sirpi", status: false),
            TagModel(label: "A.S. Creation", status: false),
            TagModel(label: "Atlas Wallcoverings N.V.", status: false),
            TagModel(label: "Limonta", status: false),
            TagModel(label: "1838", status: false),
            TagModel(label: "Origin", status: false),
            TagModel(label: "Casa Mia", status: false),
            TagModel(label: "P+S International", status: false),
            TagModel(label: "Texam Home", status: false),
            TagModel(label: "Portofino", status: false),
            TagModel(label: "Parato", status: false),
            TagModel(label: "Zambaiti (Baoding)", status: false),
            TagModel(label: "Emiliana Parati", status: false),
            TagModel(label: "Rasch Textil", status: false),
            TagModel(label: "Zambaiti", status: false),
            TagModel(label: "AdaWall", status: false),
            TagModel(label: "Erismann", status: false),
            TagModel(label: "ICH", status: false),
            TagModel(label: "Loymina", status: false),
            TagModel(label: "SK Filson", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: FiltersTableViewCellVM(name: "Страна", cells: [
            TagModel(label: "Германия", status: false),
            TagModel(label: "Нидерланды", status: false),
            TagModel(label: "Бельгия", status: false),
            TagModel(label: "Великобритания", status: false),
            TagModel(label: "США", status: false),
            TagModel(label: "Испания", status: false),
            TagModel(label: "Россия", status: false),
            TagModel(label: "Италия", status: false),
            TagModel(label: "Турция", status: false),
        ])),
        
        
        
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
        
        
        
        let indexPaths = [IndexPath(row: 0, section: section)]
        
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
        return 1
    }
    
    
    
    
    func getTappedTag() -> [String: [String]] {
        var tappedTag: [String: [String]] = [:]
        for i in cells {
            guard let activeIndexs = i.cellVM.collectionView.viewModel?.getActiveIndex() else { continue }
            if !activeIndexs.isEmpty {
                tappedTag[i.cellVM.name] = activeIndexs
            }
        }
        return tappedTag
    }
    
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FiltersTableViewCellVMType? {
        return cells[indexPath.section].cellVM
    }
    
    
    func generateSectionView(_ section: Int) -> FiltersTableViewSectionHeader {
        let sectionView = FiltersTableViewSectionHeader()
        sectionView.expandButton.tag = section
        sectionView.updateButton(expandStatus: isExpanded(section))
        sectionView.label.text = cells[section].cellVM.name
        return sectionView
    }
    
    
}
