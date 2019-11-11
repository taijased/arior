//
//  BasketService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 09.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import RealmSwift


protocol BasketServiceType {
    
    static func favoritesToBasket(id: String, completion: @escaping () -> Void)
}

class BasketService: BasketServiceType {
    static func favoritesToBasket(id: String, completion: @escaping () -> Void) {
        
        guard let object = realm.object(ofType: Goods.self, forPrimaryKey: id) else { return }
        let exist = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id) != nil
        
        if exist {
            guard let count = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id)?.count else { return }
            let currenCount = Int(count)! + 1
            let updatingBasketItem = BasketItem(goods: object)
            updatingBasketItem.count = "\(currenCount)"
            try! realm.write {
                realm.add(updatingBasketItem, update: .modified)
                
            }
            FavoriteService.delete(id: id) {
                completion()
            }
            
        } else {
            try! realm.write {
                realm.add(BasketItem(goods: object))
            }
            FavoriteService.delete(id: id) {
                completion()
            }
        }
    }
}



//MARK: RealmGRUDServiseType

extension BasketService: RealmGRUDType {
    
    typealias Input = Goods
    typealias Output = BasketItem
    
    static func create(object: Goods, completion: @escaping () -> Void) {
        let exist = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id) != nil
        if exist {
            guard let count = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id)?.count else { return }
            let currenCount = Int(count)! + 1
            let updatingBasketItem = BasketItem(goods: object)
            updatingBasketItem.count = "\(currenCount)"
            try! realm.write {
                realm.add(updatingBasketItem, update: .modified)
            }
            completion()
        } else {
            try! realm.write {
                realm.add(BasketItem(goods: object))
                completion()
            }
        }
    }
    
    static func read(id: String, completion: @escaping (BasketItem?) -> Void) {
        print(#function)
    }
    
    static func update(object: BasketItem, completion: @escaping () -> Void) {
        print(#function)
    }
    
    static func delete(id: String, completion: @escaping () -> Void) {
        print(#function)
    }
}
