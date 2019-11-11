//
//  FavoritePreviewViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 09.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


class FavoritePreviewViewController: UIViewController {
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

        view.backgroundColor = .clear
        navigationItem.title = imageName.capitalized
        let image = WebImageView()
        image.set(imageURL: imageName)

        imageView.image = image.image
        imageView.frame = view.bounds
        view.addSubview(imageView)

        // The preview will size to the preferredContentSize, which can be useful
        // for displaying a preview with the dimension of an image, for example.
        // Unlike peek and pop, it doesn't automatically scale down for you.

        let width: CGFloat
        let height: CGFloat
        
        
        let size = image.image!.size

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

