//
//  CatalogCollectionView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift
import SkeletonView





protocol CatalogCollectionViewDelegate: class {
    func selectItem()
    func selectProject(project: Project)
}

class CatalogCollectionView: UICollectionView {
    
    var viewModel: CatalogCollectionViewViewModelType?
    weak var collectionDelegate: CatalogCollectionViewDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
        
//        viewModel = CatalogCollectionViewViewModel()
        
        viewModel?.onReloadData = { [weak self] in
            print("ikol")
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
        register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    }
    
    fileprivate func setupCollectionHeader() {
        register(CatalogHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CatalogHeaderViewCell.reuseId)
        
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
extension CatalogCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.reuseId, for: indexPath) as? CatalogCollectionViewCell
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        collectionViewCell.viewModel = cellViewModel 
      
        return collectionViewCell
    }
    
    @objc func connected(sender: UIButton){
        print(#function)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        collectionDelegate?.selectItem()
    }

}





// MARK: - UICollectionViewDelegateFlowLayout
extension CatalogCollectionView: UICollectionViewDelegateFlowLayout {
    
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
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CatalogHeaderViewCell.reuseId, for: indexPath)
            as? CatalogHeaderViewCell
        
        
        guard let header = cell, let projectId =  viewModel?.projectId else { return UICollectionReusableView() }
        header.set(id: projectId)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel?.sizeForHeader() ?? CGSize.zero
    }
}


//MARK: - ProjectsCollectionViewDelegate

extension CatalogCollectionView: CatalogHeaderViewCellDelegate {
    func didSelectItemAt(project: Project) {
        self.collectionDelegate?.selectProject(project: project)
    }
}