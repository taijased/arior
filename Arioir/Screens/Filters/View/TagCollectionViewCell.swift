//
//  TagCollectionViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 17.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "TagCollectionViewCell"
    
    weak var viewModel: TagCollectionViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            tagView.backgroundColor = viewModel.status ? UIColor.Yellow.primary : UIColor.Black.light
            label.text = viewModel.label
        }
    }
    
    let tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel.H4.regular
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    

    private func setupLayers() {
        
        addSubview(tagView)
        tagView.fillSuperview()
        
        tagView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: tagView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: tagView.centerXAnchor).isActive = true
    }
    
    
 
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
