//
//  CreateTableIconsCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol CreateTableIconsCellDelegate: class {
    func getIconName(name: String)
}

class CreateTableIconsCell: UITableViewCell {
    
    
    weak var delegate: CreateTableIconsCellDelegate?
    var selectIconName: String?
    
    static let reuseId = "CreateTableIconsCell"
    
    let collectionView = IconCollectionView()
    
    let headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Выберите иконку проекта"
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.padding).isActive = true
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.collectionDelegate = self
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - IconCollectionViewDelegate
extension CreateTableIconsCell: IconCollectionViewDelegate {
    func didSelectItemAt() {
        guard let name = collectionView.viewModel?.viewModelForSelectedRow() else { return }
        self.delegate?.getIconName(name: name)
    }
}
