//
//  CustomTextField.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



class CustomTextField: UIView {
    
    var onValidText: ((String) -> Void)?
    
    private var label: String = "Test"
    private var errorMessage: String = "errorMessage"
    
    
    var textFieldLabel: String {
        get {
            return self.label
        }
        set(newValue) {
            self.label = newValue
        }
    }
    
    var errorText: String {
        get {
            return self.errorMessage
        }
        set(newValue) {
            self.errorMessage = newValue
        }
    }
    
    
    final fileprivate var isValidTextField: Bool = false
    
    final fileprivate let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    final fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        return label
    }()
    final fileprivate let underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    
    
    final fileprivate let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.font = textField.font!.withSize(16)
        textField.addTarget(self, action: #selector(textFieldDidBegin(_:)), for: .editingDidBegin)
        textField.returnKeyType = .done
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayers()
    }
    
    
    
    final fileprivate func setupLayers() {
        
        
        
        addSubview(mainView)
        mainView.fillSuperview()
        
        
        mainView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.padding + 6).isActive = true
        textField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.padding).isActive = true
        textField.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 11).isActive = true
        textField.delegate = self
        
        
        mainView.addSubview(underlineView)
        underlineView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.padding).isActive = true
        underlineView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.padding).isActive = true
        underlineView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        mainView.addSubview(labelName)
        labelName.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.padding + 6).isActive = true
        labelName.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.padding).isActive = true
        labelName.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        labelName.text = self.textFieldLabel
        
    }
    
    @objc final fileprivate func textFieldDidBegin(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.labelName.frame.origin.y = 0
            self.labelName.font = self.labelName.font.withSize(14)
            self.labelName.alpha = 0.3
            self.labelName.textColor = .black
            self.labelName.text = self.textFieldLabel
            self.mainView.backgroundColor = .clear
        })
    }
    
    
    func validTextField(_ textFieldText: String) -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    final func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        let text = textField.text!
        
        if text.isEmpty {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.labelName.frame.origin.y = 16
                self.labelName.font = self.labelName.font.withSize(16)
                self.labelName.textColor = .black
                self.labelName.alpha = 1
                self.mainView.backgroundColor = .clear
            })
        } else {
            if validTextField(text) {
                self.isValidTextField = true
                self.onValidText?(text)
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.labelName.text = self.errorText
                    self.textField.text = ""
                    self.labelName.frame.origin.y = 16
                    self.labelName.textColor = .white
                    self.mainView.backgroundColor = UIColor(hexValue: "#D00202", alpha: 1)!
                    self.labelName.alpha = 1
                })
            }

        }
        

        textField.resignFirstResponder()
        return true
    }
}

