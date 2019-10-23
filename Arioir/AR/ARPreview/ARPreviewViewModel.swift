//
//  ARPreviewViewModel.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 20/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

protocol ARPreviewModelProtocol: class
{
    func close()
    func restart()
}

class ARPreviewViewModel: UIView
{
    weak var delegate: ARPreviewModelProtocol?
    var sceneView: ARSCNView =
    {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coachingLabel: UILabel =
    {
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
    
    var closeButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "close", colorHex: "#FFFFFF", cornerRadius: 20)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        return button
        
    }()
    
    var restartButton: UIButton =
    {
        let button = UIButton.getCustomButton(imageName: "restart", colorHex: "#FFBF00", cornerRadius: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restart(_:)), for: .touchUpInside)
        return button
        
    }()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configurate()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurate()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(sceneView)
        sceneView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sceneView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(coachingLabel)
        coachingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        coachingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        coachingLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
        coachingLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(restartButton)
        restartButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        restartButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func close(_ sender: UIButton)
    {
        delegate?.close()
    }
   
    @objc func restart(_ sender: UIButton)
    {
        delegate?.restart()
    }
    
}
