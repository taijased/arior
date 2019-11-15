//
//  FiltersTableViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class FiltersTableViewCell: UITableViewCell {
    

    static let reuseId: String = "FiltersTableViewCell"
    
    weak var viewModel: FiltersTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }

            textLabel?.text = viewModel.name
        }
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .random()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
