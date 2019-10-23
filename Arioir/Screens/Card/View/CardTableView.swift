//
//  CardTableView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//



import UIKit



//
//protocol CardTableViewControllerDelegate: class {
//  weak var subcategoryDelegate: CardTableViewControllerDelegate?
//}


protocol CardTableViewDelegate: class {
    
}


class CardTableView: UITableView {
    
    weak var cardTableDelegate: CardTableViewDelegate?
    var viewModel: CardTableViewViewModelType?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    
        viewModel = CardTableViewViewModel()
        viewModel?.onReloadData = { [weak self] in
            self?.reloadData()
        }
        setupUI()
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseId)
        register(CardTableHeaderCell.self, forCellReuseIdentifier: CardTableHeaderCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
        allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







extension CardTableView: UITableViewDelegate, UITableViewDataSource {

    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if indexPath.row == 0 {
            let cell = dequeueReusableCell(withIdentifier: CardTableHeaderCell.reuseId, for: indexPath) as? CardTableHeaderCell
            guard let headerViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellHeader()
            headerViewCell.viewModel = cellViewModel
            return headerViewCell
        } else {
            let cell = dequeueReusableCell(withIdentifier: CardTableViewCell.reuseId, for: indexPath) as? CardTableViewCell
            guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            viewCell.viewModel = cellViewModel
            return viewCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }

}
