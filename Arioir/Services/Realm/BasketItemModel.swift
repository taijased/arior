//
//  BasketItemModel.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 18.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import RealmSwift



class BasketItem: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var price: String?
    @objc dynamic var count: String?
    @objc dynamic var picture: String?
    

    convenience init(goods: Goods) {
        self.init()
        self.id = goods.id
        self.name = goods.name
        self.price = goods.price
        self.count = "\(1)"
        self.picture = goods.picture
    }
    
    convenience init(id: String, name: String, price: String, count: String, picture: String) {
        self.init()
        self.id = id
        self.name = name
        self.price = price
        self.count = count
        self.picture = picture
    }
    
    convenience init(item: FavoriteItem) {
        self.init()
        self.id = item.id
        self.name = item.name
        self.price = item.price
        self.count = "\(1)"
        self.picture = item.picture
    }
    
    
    
    
    
    func getAllPrice() -> Float {
        
        let itemPrice = (self.price! as NSString).floatValue
        let itemCount = (self.count! as NSString).floatValue

        return itemPrice * itemCount
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
