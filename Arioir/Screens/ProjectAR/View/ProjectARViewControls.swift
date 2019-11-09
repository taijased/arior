//
//  ProjectARViewControls.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import ARKit

protocol ProjectARViewControlsDelegate: class {
    func close()
    func plus()
    func undo()
    func done()
    func restart()
    
}

class ProjectARViewControls: UIView
{
    
    weak var delegate: ProjectARViewControlsDelegate?
    
    var sceneView: ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var closeButton: UIButton = {
        let button = UIButton.getCustomButton(imageName: "close-yellow", colorHex: "#FFFFFF", cornerRadius: 20)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        return button
        
    }()
    
    var plusButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "plus-yellow", colorHex: "#FFFFFF", cornerRadius: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(plus(_:)), for: .touchUpInside)
        return button
        
    }()
    
    var undoButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "undo", colorHex: "#FFFFFF", cornerRadius: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(undo(_:)), for: .touchUpInside)
        return button
        
    }()
    
    var doneButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "done-white", colorHex: "#69D37B", cornerRadius: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
        return button
        
    }()
    
    var restartButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "refresh-white", colorHex: "#FFBF00", cornerRadius: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restart(_:)), for: .touchUpInside)
        return button
        
    }()
    
    
    var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(hexValue: "#FFBF00", alpha: 1)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = false
        label.text = "Hello"
        label.isHidden = true
        return label
    }()
    
    var coachingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(hexValue: "#000000", alpha: 0.3)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = false
        label.text = "Hello"
        return label
    }()
    
    @objc func close(_ sender: UIButton) {
        sender.flash()
        delegate?.close()
    }
    
    @objc func plus(_ sender: UIButton) {
        sender.flash()
        delegate?.plus()
    }
    
    @objc func undo(_ sender: UIButton) {
        sender.flash()
        delegate?.undo()
    }
    @objc func done(_ sender: UIButton) {
        sender.flash()
        delegate?.done()
    }
    @objc func restart(_ sender: UIButton) {
        sender.flash()
        delegate?.restart()
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(sceneView)
        sceneView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sceneView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(plusButton)
        plusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(restartButton)
        restartButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        restartButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(undoButton)
        undoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        undoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(doneButton)
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(heightLabel)
        heightLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        heightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -121).isActive = true
        heightLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        heightLabel.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        addSubview(coachingLabel)
        coachingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        coachingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        coachingLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
        coachingLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
