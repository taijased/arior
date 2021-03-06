//
//  ProjectsCollectionView.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 14.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol ProjectsCollectionViewDelegate: class {
    func didSelectItemAt()
}


class ProjectsCollectionView: UICollectionView {
    
    weak var collectionDelegate: ProjectsCollectionViewDelegate?
    
    var viewModel: ProjectsCollectionViewViewModelType?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        viewModel = ProjectsCollectionViewViewModel()
        viewModel?.onReloadData = {
            self.reloadData()
        }
        setupCollectionSettings()
    }
    
    
    private func setupCollectionSettings() {
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: ProjectsCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        isPagingEnabled = true
        decelerationRate = .fast
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProjectsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ProjectsCollectionViewCell.reuseId, for: indexPath) as? ProjectsCollectionViewCell
        
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        collectionViewCell.viewModel = cellViewModel
        
        return collectionViewCell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        collectionDelegate?.didSelectItemAt()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProjectsCollectionView: UICollectionViewDelegateFlowLayout {
    
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






//MARK: - ProjectsContextViewMenu

extension ProjectsCollectionView: ProjectsContextViewMenu {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let viewModel = viewModel else { return nil }
        viewModel.selectItem(atIndexPath: indexPath)
        guard let project = viewModel.viewModelForSelectedRow() else { return nil}
        
        let identifier = NSString(string: project.iconName!)
        
        // Create our configuration with an indentifier
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: {
            return ProjectsPreviewViewController(imageName: project.iconName!)
        }, actionProvider: { suggestedActions in
            return self.makeDefaultDemoMenu { type in
                viewModel.contextMenuActions(type: type)
            }
        })
    }
}
