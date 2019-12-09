//
//  TagCollectionView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 17.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import AlignedCollectionViewFlowLayout


protocol TagCollectionViewDelegate: class {
    func didSelectItemAt()
}


class TagCollectionView: UICollectionView {
    
    weak var collectionDelegate: TagCollectionViewDelegate?
    
    var viewModel: TagCollectionViewVMType?
    
    init(cells: [TagModel]) {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        super.init(frame: .zero, collectionViewLayout: layout)
        
        viewModel = TagCollectionViewVM(cells: cells)
        viewModel?.onReloadData = {
            self.reloadData()
        }
        setupCollectionSettings()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        super.init(frame: .zero, collectionViewLayout: layout)
        viewModel?.onReloadData = {
            self.reloadData()
        }
        setupCollectionSettings()
    }
    

    private func setupCollectionSettings() {
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: Constants.padding, bottom: 20, right: Constants.padding)
        isScrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TagCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseId, for: indexPath) as? TagCollectionViewCell
        
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        collectionViewCell.viewModel = cellViewModel
        
        return collectionViewCell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TagCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return viewModel?.sizeForItemAt(indexPath) ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumInteritemSpacingForSectionAt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumLineSpacingForSectionAt ?? 0
    }
    
}

