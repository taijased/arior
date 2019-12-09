//
//  HomeCollectionView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift
import SkeletonView





protocol HomeCollectionViewDelegate: class {
    func selectItem()
    func selectProject(project: Project)
}

class HomeCollectionView: UICollectionView {
    
    var viewModel: HomeCollectionViewViewModelType?
    weak var collectionDelegate: HomeCollectionViewDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
        
        viewModel = HomeCollectionViewViewModel()
        
        viewModel?.onReloadData = { [weak self] in
            self?.reloadData()
        }
        
    }
    
    
    fileprivate func setupUI() {
        reloadData()
        setupCollectionSettings()
        setupCollectionHeader()
        setupCollectionViewLayout()
    }
    
    fileprivate func setupCollectionSettings() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    }
    
    fileprivate func setupCollectionHeader() {
        register(HomeHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderViewCell.reuseId)
        
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: Constants.padding, left: Constants.padding, bottom: 0, right: Constants.padding)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension HomeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseId, for: indexPath) as? HomeCollectionViewCell
        cell?.onReloadCell = { [weak self] in
            self?.reloadItems(at: [indexPath])
        }
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        collectionViewCell.viewModel = cellViewModel
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        collectionDelegate?.selectItem()
    }

}





// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCollectionView: UICollectionViewDelegateFlowLayout {
    
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
    
    
    // MARK: - Add HomeHeaderViewCell
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderViewCell.reuseId, for: indexPath)
            as? HomeHeaderViewCell
        guard let header = cell else { return UICollectionReusableView() }
        header.delegate = self
        header.viewModel?.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel?.sizeForHeader() ?? CGSize.zero
    }
}


//MARK: - ProjectsCollectionViewDelegate

extension HomeCollectionView: HomeHeaderViewCellDelegate {
    func didSelectItemAt(project: Project) {
        self.collectionDelegate?.selectProject(project: project)
    }
}
