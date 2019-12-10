//
//  FavoriteCollectionViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit



class FavoriteCollectionViewCell: UICollectionViewCell {
    
    
    var onReloadCell: ((Bool) -> Void)?
    var onNavigation: ((FavoriteNavigation) -> Void)?
    
    static let reuseId = "FavoriteCollectionViewCell"
    
    private var gradientLayer: CAGradientLayer?
    
    //weak maybe?
    var viewModel: FavoriteCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            myImageView.set(imageURL: viewModel.imageURL)
            label.text = viewModel.label
            let imageName = viewModel.isFromProject ? "project-done" : "project-empty"
            buttonProject.setImage(UIImage(named: imageName), for: .normal)
            buttonFavorite.addTarget(self, action: #selector(buttonFavoriteTapped), for: .touchUpInside)
            cartFavorite.addTarget(self, action: #selector(buttonCartTapped), for: .touchUpInside)
            buttonProject.addTarget(self, action: #selector(buttonProjectTapped), for: .touchUpInside)
        }
    }
    
    
    //MARK: - cell target Selectors
    
    @objc func buttonFavoriteTapped(_ sender: UIButton) {
        sender.flash()
        viewModel?.controlsAction(.favorite) { [weak self] hidden in
            if hidden {
                self?.onNavigation?(.dissmis)
            } else {
                self?.onReloadCell?(false)
            }
        }
    }
    
    @objc func buttonCartTapped(_ sender: UIButton) {
        sender.flash()
        viewModel?.controlsAction(.cart, completion: { [weak self] hidden in
            if hidden {
                self?.onNavigation?(.dissmis)
            } else {
                self?.onReloadCell?(false)
            }
        })
    }
    
    @objc func buttonProjectTapped(_ sender: UIButton) {
        sender.flash()
        viewModel?.controlsAction(.project, completion: { [weak self] _ in
            self?.onReloadCell?(true)
        })
        
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
        let label = UILabel.H4.medium
        label.text = "Кровати"
        return label
    }()
    
    fileprivate let viewGradientMask: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let buttonFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorites-fill"), for: .normal)
        return button
    }()
    
    let cartFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cart"), for: .normal)
        return button
    }()
    
    let buttonProject: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
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
        
        
        addSubview(buttonFavorite)
        buttonFavorite.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        buttonFavorite.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        buttonFavorite.heightAnchor.constraint(equalToConstant: 22).isActive = true
        buttonFavorite.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(cartFavorite)
        cartFavorite.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cartFavorite.leadingAnchor.constraint(equalTo: buttonFavorite.trailingAnchor, constant: 8).isActive = true
        cartFavorite.heightAnchor.constraint(equalToConstant: 22).isActive = true
        cartFavorite.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(buttonProject)
        buttonProject.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        buttonProject.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        buttonProject.heightAnchor.constraint(equalToConstant: 22).isActive = true
        buttonProject.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
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
