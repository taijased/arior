//
//  StorageManager.swift
//
//  Created by Максим Спиридонов on 15.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

protocol RealmGRUDType {
    associatedtype Input
    associatedtype Output
    static func create(object: Input, completion: @escaping () -> Void)
    static func read(id: String, completion: @escaping (Output?) -> Void)
    static func update(object: Output, completion: @escaping () -> Void)
    static func delete(id: String, completion: @escaping () -> Void)
}




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
    
    
//    static func deleteObject(_ object: Goods) {
//        try! realm.write {
//            realm.delete(object)
//        }
//    }

 


    static func clearData() {
        try! realm.write {
            realm.deleteAll()
            print(#function)
        }
    }
    
    
    
    static func saveProject(_ name: String, iconName: String, completion: @escaping () -> Void) {
        let identifier = UUID()
        try! realm.write {
            realm.add(Project(id: "\(identifier)", name: name, iconName: iconName))
            completion()
        }
    }
    
    
}
