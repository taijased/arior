//
//  ProjectGoodsCollectionViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

class ProjectGoodsCollectionViewCell: UICollectionViewCell {
    
    
    var onReloadData: ((Bool) -> Void)?
    
    static let reuseId = "ProjectGoodsCollectionViewCell"
    
    //weak ?
    var viewModel: ProjectGoodsCollectionViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            myImageView.set(imageURL: viewModel.iconName)
            label.text = viewModel.label
            buttonDelete.addTarget(self, action: #selector(buttonDeleteTapped), for: .touchUpInside)
        }
    }
    
    
    @objc func buttonDeleteTapped(_ sender: UIButton) {
       viewModel?.controlsAction(.delete, completion: { [weak self] status in
           self?.onReloadData?(status)
       })
    }
    
    
    var buttonDelete: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "delete-cell"), for: .normal)
        return button
    }()
    
    
    
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    fileprivate let viewGradientMask: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Black.primary
        label.font = UIFont.getTTNormsFont(type: .bold, size: 14.0)
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
        
        
        
        // second layer
        myImageView.addSubview(viewGradientMask)
        viewGradientMask.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
        viewGradientMask.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor).isActive = true
        viewGradientMask.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
        viewGradientMask.heightAnchor.constraint(equalToConstant: 42).isActive = true
        // thrid layer
        
        // add gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
                                UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor]
        
        gradientLayer.locations = [0.0, 0.3]
        gradientLayer.frame = bounds
        viewGradientMask.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        addSubview(label)
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        
        
        addSubview(buttonDelete)
        buttonDelete.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        buttonDelete.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        buttonDelete.heightAnchor.constraint(equalToConstant: 22).isActive = true
        buttonDelete.widthAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        viewModel = nil
    }
}
