//
//  ProjectGoodsCollectionViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

class ProjectGoodsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ProjectGoodsCollectionViewCell"
    
    weak var viewModel: ProjectGoodsCollectionViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            myImageView.set(imageURL: viewModel.iconName)
            label.text = viewModel.label
        }
    }
    
    
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 10
        view.layer.position = view.center
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        return view
    }()
    
    fileprivate let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8882605433, green: 0.8981810212, blue: 0.9109882712, alpha: 1)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    

    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexValue: "#4A4A4A", alpha: 1.0)
        label.font = label.font.withSize(14)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    
    private func setupLayers() {
        
        backgroundColor = .clear
        addSubview(cardView)
        cardView.fillSuperview()
        
        cardView.addSubview(myImageView)
        myImageView.fillSuperview()
        
           
        addSubview(label)
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.shadowRadius = 7
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        viewModel = nil
    }
}
