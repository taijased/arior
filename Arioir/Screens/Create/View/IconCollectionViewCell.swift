//
//  IconCollectionViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "IconCollectionViewCell"
    
    
    
    
    weak var viewModel: IconCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            iconImage.image = UIImage(named: viewModel.iconName)
            updateImage(viewModel.selected)
        }
    }
    
    
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "selected")
        imageView.isHidden = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    override func prepareForReuse() {
        iconImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    fileprivate func updateImage(_ bool: Bool) {
        DispatchQueue.main.async {
            if bool {
                self.selectedImage.isHidden = false
                self.iconImage.alpha = 1
            } else {
                self.selectedImage.isHidden = true
                self.iconImage.alpha = 0.3
            }
        }
    }
    
    fileprivate func setupUI() {
        addSubview(iconImage)
        iconImage.fillSuperview()
        
        addSubview(selectedImage)
        selectedImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6).isActive = true
        selectedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6).isActive = true
        selectedImage.widthAnchor.constraint(equalToConstant: 22).isActive = true
        selectedImage.heightAnchor.constraint(equalToConstant: 22).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
