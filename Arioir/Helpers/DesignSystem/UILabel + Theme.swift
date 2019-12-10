//
//  UILabel + Theme.swift
//  Arioir
//
//  Created by Максим Спиридонов on 10.12.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

extension UILabel {
    
    enum H1 {
        static var bold: UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.Black.primary
            label.font = UIFont.getTTNormsFont(type: TTNorms.bold, size: 26)
            return label
        }
    }
    enum H3 {
        static var medium: UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.Black.primary
            label.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 16)
            return label
        }
    }
    enum H4 {
        static var medium: UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor =  UIColor.Black.primary
            label.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 14)
            return label
        }
        static var regular: UILabel {
             let label = UILabel()
             label.translatesAutoresizingMaskIntoConstraints = false
             label.textColor =  UIColor.Black.primary
             label.font = UIFont.getTTNormsFont(type: TTNorms.regular, size: 14)
             return label
        }
    }
    enum H5 {
        static var regular: UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.Black.primary
            label.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 12)
            return label
        }
    }
}






//MARK: - Font Extension
// toDO
//enum TTNorms {
//    static let bold: String =  "TTNorms-Bold"
//    static let medium: String = "TTNorms-Medium"
//    static let regular: String = "TTNorms-Regular"
//}


enum TTNorms {
    case bold
    case medium
    case regular
}



extension UIFont {
    
    static func getTTNormsFont(type: TTNorms, size fontSize: CGFloat) -> UIFont {
        
        var fontName: String
        switch type {
            
        case .bold:
            fontName = "TTNorms-Bold"
            break
        case .medium:
            fontName = "TTNorms-Medium"
            break
        case .regular:
            fontName =  "TTNorms-Regular"
            break
            
        }
        
        guard let font = UIFont(name: fontName , size: fontSize) else { return UIFont.systemFont(ofSize: fontSize) }
        return font
    }
    
}
