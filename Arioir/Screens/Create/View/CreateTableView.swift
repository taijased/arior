//
//  CreateTableView.swift
//  Arioir
//
//  Created by Максим Спиридонов on 26.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol CreateTableViewDelegate: class {
    func deinitView()
    func showError(title: String)
}


class CreateTableView: UITableView {
    
    private var projectName: String?
    private var projectIcon: String?
    
    
    private let customRefreshControl = UIRefreshControl()
    var viewModel: CreateTableViewViewModelType?
    weak var createDelegate: CreateTableViewDelegate?
    

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        viewModel = CreateTableViewViewModel()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(CreateTableTextfieldCell.self, forCellReuseIdentifier: CreateTableTextfieldCell.reuseId)
        register(CreateTableIconsCell.self, forCellReuseIdentifier: CreateTableIconsCell.reuseId)
        register(CreateTableButtonCell.self, forCellReuseIdentifier: CreateTableButtonCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
        
        
        //костыль чтобы при скроле закрыть вью
        addSubview(customRefreshControl)
        customRefreshControl.alpha = 0
        customRefreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        createDelegate?.deinitView()
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


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CreateTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        switch indexPath.row {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: CreateTableTextfieldCell.reuseId, for: indexPath) as? CreateTableTextfieldCell
            guard let textfieldCell = cell else { return UITableViewCell() }
            textfieldCell.textField.delegate = self
            return textfieldCell
        case 1:
            let cell = dequeueReusableCell(withIdentifier: CreateTableIconsCell.reuseId, for: indexPath) as? CreateTableIconsCell
            guard let iconsCell = cell else { return UITableViewCell() }
            iconsCell.delegate = self
            return iconsCell
        case 2:
            let cell = dequeueReusableCell(withIdentifier: CreateTableButtonCell.reuseId, for: indexPath) as? CreateTableButtonCell
            guard let buttonCell = cell else { return UITableViewCell() }
            buttonCell.button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
            
            return buttonCell
        default:
            return  UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
    @objc func createButtonTapped(_ sender: UIButton) {
        sender.flash()
   
        
        if (projectName ?? "").isEmpty {
            self.createDelegate?.showError(title: "Введите название проекта")
            return
        }
        
        if (projectIcon ?? "").isEmpty {
            self.createDelegate?.showError(title: "Выберите иконку проекта")
            return
        }
        

        print(projectIcon! + " "  + projectName!)
        
        
        
    }
}


//MARK:  - UITextFieldDelegate

extension CreateTableView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        projectName = textField.text
        self.endEditing(true)
        return false
    }
}





//MARK: - CreateTableIconsCellDelegate

extension CreateTableView: CreateTableIconsCellDelegate {
    func getIconName(name: String) {
        projectIcon = name
    }
}

