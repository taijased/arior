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
}

class CatalogHeaderViewCell: UICollectionReusableView {
    
    static let reuseId = "CatalogHeaderViewCell"
    weak var delegate: CatalogHeaderViewCellDelegate?
    
    var viewModel: CatalogHeaderViewCellVMlType?
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 1)
        label.font = label.font.withSize(26)
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        label.text = "Название проекта"
        return label
    }()
    
    
    
    let catalogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 1)
        label.font = label.font.withSize(26)
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        label.text = "Каталог"
        return label
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 1)
        label.font = label.font.withSize(14)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Начните добавлять товары ниже из каталога"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        addConstrints()
    }
    
    func set(id: String) {
        
        
        viewModel = CatalogHeaderViewCellVM(projectId: id)
        DispatchQueue.main.async {
            self.projectLabel.text = self.viewModel?.projectName
        }
       
        guard let collectionView = viewModel?.collectionView else { return }
        addSubview(collectionView)
        collectionView.collectionDelegate = self
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: projectLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: catalogLabel.topAnchor).isActive = true
        collectionView.collectionDelegate = self
        collectionView.reloadData()
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

        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





//MARK: - ProjectsCollectionViewDelegate
extension CatalogHeaderViewCell: ProjectGoodsCollectionViewDelegate {
    func didSelectItemAt() {
//        guard let project = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
//        self.delegate?.didSelectItemAt(project: project)
    }
    
    
}