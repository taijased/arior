//
//  HomeCollectionViewCell.swift
//  mvvm
//
//  Created by Максим Спиридонов on 21.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit




class HomeCollectionViewCell: UICollectionViewCell {
    
    
    
    var onReloadCell: (() -> Void)?
    static let reuseId = "HomeCollectionViewCell"
    
    private var gradientLayer: CAGradientLayer?
    
    
    // weak должно быть но че то хуета
    var viewModel: HomeCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            myImageView.set(imageURL: viewModel.imageURL)
            label.text = viewModel.label
            buttonFavorite.addTarget(self, action: #selector(buttonFavoriteTapped), for: .touchUpInside)
            if viewModel.isFavorites {
                buttonFavorite.setImage(UIImage(named: "favorites-fill"), for: .normal)
            } else {
                buttonFavorite.setImage(UIImage(named: "favorites"), for: .normal)
            }
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
        let label = UILabel.H5.regular
        return label
    }()
    
    fileprivate let viewGradientMask: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let buttonFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc fileprivate func buttonFavoriteTapped(_ sender: UIButton) {
        sender.flash()
        Vibration.success.vibrate()
        viewModel?.updateFavoriteStatus()
        onReloadCell?()
    }

    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        addSubview(cardView)
        cardView.fillSuperview()
        
        cardView.addSubview(myImageView)
        myImageView.fillSuperview()
        
//        
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
        
        
        addSubview(buttonFavorite)
        buttonFavorite.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        buttonFavorite.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonFavorite.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonFavorite.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
