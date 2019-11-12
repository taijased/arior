//
//  ProjectsPreviewViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//
//


import UIKit


class ProjectsPreviewViewController: UIViewController {
    private let imageName: String
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.backgroundColor = .clear
        return image
    }()
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .clear
        navigationItem.title = imageName.capitalized
        
        imageView.image = UIImage(named: imageName)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        
        let width: CGFloat
        let height: CGFloat
        
        
        guard let size = imageView.image?.size else { return }
        
        if size.width > size.height {
            width = view.frame.width
            height = size.height * (width / size.width)
        } else {
            height = view.frame.height
            width = size.width * (height / size.height)
        }
        
        preferredContentSize = CGSize(width: width, height: height)
    }
}

