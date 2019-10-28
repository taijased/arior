//
//  OrderTableDeliveryViewCell.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit



protocol OrderTableDeliveryViewCellDelegate: class {
    func resultForm(type: OrderModel, _ result: String)
}



class OrderTableDeliveryViewCell: UITableViewCell {
    
    static let reuseId = "OrderTableDeliveryViewCell"
    weak var delegate: OrderTableDeliveryViewCellDelegate?
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.textAlignment = .left
        label.text = "Доставка"
        return label
    }()
    
    let segmentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = primaryColor
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Самовывоз", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Доставка курьером", at: 1, animated: true)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlChenge(_:)), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.selectedSegmentTintColor = primaryColor
        //        segmentedControl.backgroundColor = UIColor.init(hexValue: "#fff", alpha: 1.0)
        segmentedControl.layer.borderColor = primaryColor!.cgColor
        
        //        segmentedControl.layer.borderWidth = 1
        //
        //        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
        //
        //        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        
        
        return segmentedControl
    }()
    
    @objc func segmentControlChenge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            delegate?.resultForm(type: .delivery, "Самовывоз")
        case 1:
            delegate?.resultForm(type: .delivery, "Доставка курьером")
        default:
            break
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding + 6).isActive = true
        
        
        
        
        
        addSubview(segmentControl)
        segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//
//extension UIImage {
//
//    convenience init?(color: UIColor, size: CGSize) {
//        UIGraphicsBeginImageContextWithOptions(size, false, 1)
//        color.set()
//        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
//        ctx.fill(CGRect(origin: .zero, size: size))
//        guard
//            let image = UIGraphicsGetImageFromCurrentImageContext(),
//            let imagePNGData = image.pngData()
//            else { return nil }
//        UIGraphicsEndImageContext()
//
//        self.init(data: imagePNGData)
//    }
//}
//
//extension UISegmentedControl {
//
//    func fallBackToPreIOS13Layout(using tintColor: UIColor) {
//        if #available(iOS 13, *) {
//            let backGroundImage = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
//            let dividerImage = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))
//
//            setBackgroundImage(backGroundImage, for: .normal, barMetrics: .default)
//            setBackgroundImage(dividerImage, for: .selected, barMetrics: .default)
//
//            setDividerImage(dividerImage,
//                            forLeftSegmentState: .normal,
//                            rightSegmentState: .normal, barMetrics: .default)
//
//            layer.borderWidth = 1
//            layer.borderColor = tintColor.cgColor
//
//            setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
//            setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//        } else {
//            self.tintColor = tintColor
//        }
//    }
//}
