//
//  BasketTableViewCell.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 17.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit




protocol BasketTableViewCellDelegate: class {
    func onTrashButton(id: String)
    func onChangheInfo()
}

class BasketTableViewCell: UITableViewCell {
    
    
    weak var delegate: BasketTableViewCellDelegate?
    
    var id: String?
    
    static let reuseId: String = "BasketTableViewCell"
    let controls = BasketCellControls()
    
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let cellImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    let cellImage: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8882605433, green: 0.8981810212, blue: 0.9109882712, alpha: 1)
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Rasch Kids & Teens II 247619"
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = primaryColorGray
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "2 790,00 ₽/шт."
        return label
    }()
    
    let labelAllPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = primaryColorGray
        label.font = label.font.withSize(16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "16 740,00 ₽"
        return label
   }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        
        setupImage()
        setupControls()
        setupLabels()
    }
    
    fileprivate func setupImage(){
        
        cellView.addSubview(cellImageView)
        cellImageView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        cellImageView.addSubview(cellImage)
        cellImage.fillSuperview()
        
    }
    
    fileprivate func setupControls() {
        cellView.addSubview(controls)
        controls.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12).isActive = true
        controls.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        controls.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        controls.heightAnchor.constraint(equalToConstant: 32).isActive = true
        controls.delegate = self
    }
    
    
    fileprivate func setupLabels() {
        
        cellView.addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12).isActive = true
        labelName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        
        cellView.addSubview(labelAllPrice)
        labelAllPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 6).isActive = true
        labelAllPrice.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12).isActive = true
        labelAllPrice.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        cellView.addSubview(labelPrice)
        labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 6).isActive = true
        labelPrice.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        labelPrice.heightAnchor.constraint(equalToConstant: 19).isActive = true

    }
    
    
    func set(_ viewModel: BasketItem) {
        self.labelName.text = viewModel.name
        self.cellImage.set(imageURL: viewModel.picture)
        self.labelPrice.text = "\(viewModel.price!) ₽/шт."
        self.labelAllPrice.text = "\(viewModel.getAllPrice()) ₽"
        self.controls.count = Int(viewModel.count!)!
        self.id = viewModel.id
        self.controls.updateLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK: - BasketCellControlsDelegate

extension BasketTableViewCell: BasketCellControlsDelegate {
    func getCount(_ count: Int) {
        StorageManager.updateCoutBasketItem(id: self.id!, newCount: "\(count)") { [weak self] in
            self?.delegate?.onChangheInfo()
        }
    }
    
    func trash() {
        self.delegate?.onTrashButton(id: self.id!)
        self.delegate?.onChangheInfo()
    }
}
