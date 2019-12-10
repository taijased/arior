//
//  CardTableHeaderCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//
//


import UIKit


protocol CardTableHeaderCellDelegate: class {
    
}

class CardTableHeaderCell: UITableViewCell {
    
    weak var cardHeaderDelegate: CardTableHeaderCellDelegate?
    
        
    
    weak var viewModel: CardTableHeaderCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            headerLabel.text = viewModel.name
            myImageView.set(imageURL: viewModel.imageURL)
             
        }
    }
    
    static let reuseId = "CardTableHeaderCell"
    static let height: CGFloat = Constants.cardHeaderHeight
    
    
    let headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "H1 Label"
        label.textAlignment = .left
        return label
    }()
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexValue: "#19191B", alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = Constants.cornerRadius
        
        return view
    }()
    
    
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8882605433, green: 0.8981810212, blue: 0.9109882712, alpha: 1)
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        setupConstrints()
    }
    
    
    fileprivate func setupConstrints() {
        
        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        
        addSubview(cardView)
        cardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 22).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: Constants.cardImageHeight).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: Constants.cardImageHeight).isActive = true
        
        cardView.addSubview(myImageView)
        myImageView.fillSuperview()
        
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Constants.padding).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
