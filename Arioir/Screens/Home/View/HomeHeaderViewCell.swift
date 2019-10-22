//
//  HomeHeaderViewCell.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 13.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit



protocol HomeHeaderViewCellDelegate: class {
    func didSelectItemAt(project: Project)
}

class HomeHeaderViewCell: UICollectionReusableView {
    
    static let reuseId = "HomeHeaderViewCell"
    weak var delegate: HomeHeaderViewCellDelegate?

    var viewModel: HomeHeaderViewCellViewModelType?

    
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
        label.text = "Проекты"
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel = HomeHeaderViewCellViewModel()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        addConstrints()
    }
    
    
    fileprivate func addConstrints() {
        
        addSubview(projectLabel)
        projectLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        projectLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        projectLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        projectLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        

        addSubview(catalogLabel)
        catalogLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        catalogLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        catalogLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        catalogLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        guard let collectionView = viewModel?.collectionView else { return }
        addSubview(collectionView)
//        collectionView.projectDelegate = self
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        collectionView.collectionDelegate = self
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





//MARK: - ProjectsCollectionViewDelegate
extension HomeHeaderViewCell: ProjectsCollectionViewDelegate {
    func didSelectItemAt() {
        guard let project = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        self.delegate?.didSelectItemAt(project: project)
    }
}
