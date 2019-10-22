//
//  StorageManager.swift
//
//  Created by Максим Спиридонов on 15.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import RealmSwift

let realm = try! Realm()


class StorageManager {
    static func saveObject(_ object: Goods, completion: @escaping () -> Void) {
        try! realm.write {
            realm.add(object)
            completion()
        }
    }
    static func saveToOrder(_ object: Goods, completion: @escaping () -> Void) {
        
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
    
    static func updateCoutBasketItem(id: String, newCount: String, completion: @escaping () -> Void) {
        guard let basketItem = realm.object(ofType: BasketItem.self, forPrimaryKey: id) else { return }
        let updatingBasketItem = BasketItem(id: id, name: basketItem.name!, price: basketItem.price!, count: newCount, picture: basketItem.picture!)
        try! realm.write {
            realm.add(updatingBasketItem, update: .modified)
            completion()
        }
    }
    
    
    static func deleteObject(_ object: Goods) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    static func deleteBasketItem(_ id: String, completion: @escaping () -> Void ) {
        
        guard let basketItem = realm.object(ofType: BasketItem.self, forPrimaryKey: id) else { return }
        try! realm.write {
            realm.delete(basketItem)
            completion()
        }
    }
    
    
    static func addDefaultProject(completion: @escaping () -> Void) {
        let exist = realm.object(ofType: Project.self, forPrimaryKey: "1") != nil
        if exist {
            completion()
        } else {
            try! realm.write {
                realm.add(Project(id: "1", name: "Создать новый", iconName: "icon_1"))
                completion()
            }
        }
    }


    static func clearData() {
        try! realm.write {
            realm.deleteAll()
            print(#function)
        }
    }
    
    
}
