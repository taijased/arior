//
//  FavoriteCollectionView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift



protocol FavoriteCollectionViewDelegate: class {
    func selectItem()
    func selectProject(project: Project)
    func dismisController()
}

class FavoriteCollectionView: UICollectionView {
    
    var viewModel: FavoriteCollectionViewViewModelType?
    weak var collectionDelegate: FavoriteCollectionViewDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
        
        viewModel = FavoriteCollectionViewViewModel()
        
        viewModel?.onReloadData = { [weak self] in
            self?.reloadData()
        }
        
    }
    
    
    fileprivate func setupUI() {
        reloadData()
        setupCollectionSettings()
        setupCollectionViewLayout()
        setupCollectionHeader()
    }
    
    fileprivate func setupCollectionSettings() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: Constants.padding, left: Constants.padding, bottom: 0, right: Constants.padding)
        }
    }
    
    fileprivate func setupCollectionHeader() {
        register(FavoriteCollectionHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoriteCollectionHeaderViewCell.reuseId)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension FavoriteCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.reuseId, for: indexPath) as? FavoriteCollectionViewCell
        
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
        //        collectionDelegate?.selectItem()
    }
    
    // MARK: - Add HomeHeaderViewCell
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavoriteCollectionHeaderViewCell.reuseId, for: indexPath)
            as? FavoriteCollectionHeaderViewCell
        guard let header = cell else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}





// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteCollectionView: UICollectionViewDelegateFlowLayout {
    
    
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




//MARK: - CustomContextViewMenu

extension FavoriteCollectionView: CustomContextViewMenu {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let viewModel = viewModel else { return nil }
        viewModel.selectItem(atIndexPath: indexPath)
        guard let favoriteItem = viewModel.viewModelForSelectedRow() else { return nil}
        
        let identifier = NSString(string: favoriteItem.picture!)
        
        // Create our configuration with an indentifier
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: {
            return FavoritePreviewViewController(imageName: favoriteItem.picture!)
        }, actionProvider: { suggestedActions in
            return self.makeDefaultDemoMenu { type in
                viewModel.contextMenuActions(type: type) { [weak self] hidden in
                    if hidden {
                        self?.collectionDelegate?.dismisController()
                    }
                }
            }
        })
    }
}
