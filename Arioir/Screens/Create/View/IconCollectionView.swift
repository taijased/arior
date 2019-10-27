//
//  IconCollectionView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol IconCollectionViewDelegate: class {
    func didSelectItemAt()
}


class IconCollectionView: UICollectionView {
    
    weak var collectionDelegate: IconCollectionViewDelegate?
    
    var viewModel: IconCollectionViewViewModelType?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        viewModel = IconCollectionViewViewModel()
        setupCollectionSettings()
    }
    

    private func setupCollectionSettings() {
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(IconCollectionViewCell.self, forCellWithReuseIdentifier: IconCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: Constants.padding, bottom: 0, right: Constants.padding)
        isPagingEnabled = true
        decelerationRate = .fast
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension IconCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: IconCollectionViewCell.reuseId, for: indexPath) as? IconCollectionViewCell
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
               
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
       
        collectionViewCell.viewModel = cellViewModel
       
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        reloadData()
        collectionDelegate?.didSelectItemAt()
    }
    
    // скороллинг по одной карточке ???
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = cellForItem(at: index)!
        let position = contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width / 2 {
            index.row = index.row + 1
        }
        scrollToItem(at: index, at: .left, animated: true )
    }
    

    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension IconCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return viewModel?.sizeForItemAt() ?? CGSize.zero
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

