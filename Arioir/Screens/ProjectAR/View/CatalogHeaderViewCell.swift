//
//  CatalogHeaderViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit



protocol CatalogHeaderViewCellDelegate: class {
    func didSelectItemAt(project: Project)
    func updateData()
}

class CatalogHeaderViewCell: UICollectionReusableView {
    
    static let reuseId = "CatalogHeaderViewCell"
    weak var delegate: CatalogHeaderViewCellDelegate?
    
    
    weak var viewModel: CatalogHeaderViewCellVMlType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            projectLabel.text = viewModel.projectName
            collectionView.viewModel = viewModel.viewModel
            collectionView.onReloadData = { [weak self] in
                self?.updateData()
            }
            collectionView.updateBackground()
            collectionView.reloadData()
        }
    }
    
    let collectionView = ProjectGoodsCollectionView()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Black.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    
    let recomendationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let projectLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Название проекта"
        return label
    }()
    
    
    let catalogLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Каталог"
        return label
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel.H4.medium
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Начните добавлять товары ниже из каталога"
        return label
    }()
    
    let tempView: UIView = {
        let view = UIView()
        view.backgroundColor = .random()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        addConstrints()
    }
    
    fileprivate func addConstrints() {
        
        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        addSubview(projectLabel)
        projectLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        projectLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        projectLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 22).isActive = true
        projectLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        addSubview(catalogLabel)
        catalogLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        catalogLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        catalogLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        catalogLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        addSubview(emptyLabel)
        emptyLabel.topAnchor.constraint(equalTo: projectLabel.bottomAnchor).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: catalogLabel.topAnchor).isActive = true
        
        
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: projectLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: catalogLabel.topAnchor).isActive = true
        collectionView.collectionDelegate = self
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





//MARK: - ProjectGoodsCollectionViewDelegate
extension CatalogHeaderViewCell: ProjectGoodsCollectionViewDelegate {
    func updateData() {
        print(#function)
        delegate?.updateData()
    }
    
    func didSelectItemAt() {
        
        
        
        print(#function)
        //        guard let project = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        //        self.delegate?.didSelectItemAt(project: project)
    }
    
    
}
