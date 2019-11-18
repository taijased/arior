//
//  FiltersTableView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


struct ExpandableNames {
    var isExpanded: Bool
    let sectionLabel: String
    let names: [String]
}



class FiltersTableView: UITableView {
    
    
    
    
    var viewModel: FiltersTableViewVMType?
    
    
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        viewModel = FiltersTableViewVM()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        viewModel?.onReloadData = {
            self.reloadData()
        }
        
        viewModel?.onDeleteRows = { indexPaths in
            self.deleteRows(at: indexPaths, with: .fade)
        }
        
        viewModel?.onInsertRows = { indexPaths in
            self.insertRows(at: indexPaths, with: .fade)
        }
        
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(FiltersTableViewCell.self, forCellReuseIdentifier: FiltersTableViewCell.reuseId)
        tableHeaderView = viewModel?.headerView
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
     
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
        allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        guard let viewModel = viewModel else { return }
        viewModel.expandSection(section)
        if viewModel.isExpanded(section) {
            UIView.animate(withDuration: 0.3) {
                button.setImage(UIImage(named: "arrow-down"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                button.setImage(UIImage(named: "arrow-top"), for: .normal)
            }
        }
        
    }
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension FiltersTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }
        let sectionView = viewModel.generateSectionView(section)
        sectionView.expandButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.heightForHeaderInSection ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: FiltersTableViewCell.reuseId, for: indexPath) as? FiltersTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel

        let cellHeight = viewCell.viewModel?.collectionView.viewModel?.getHeightCell()
        viewModel.setHeightForRowAt(cellHeight!)
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath) ?? 0
    }

}
