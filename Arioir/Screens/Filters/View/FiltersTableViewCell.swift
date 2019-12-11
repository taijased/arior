//
//  FiltersTableViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class FiltersTableViewCell: UITableViewCell {
    
    
    static let reuseId: String = "FiltersTableViewCell"
    
    let collectionView = TagCollectionView()
    
    
    weak var viewModel: FiltersTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            collectionView.viewModel = viewModel.collectionView.viewModel
            collectionView.reloadData()
            collectionView.viewModel?.onReloadData = {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
