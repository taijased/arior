//
//  FavoriteService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 09.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import RealmSwift


protocol FavoriteServiceType {
    static func isEmpty() -> Bool
    func favoritesToBasket(completion: @escaping () -> Void)
    func clearAll(completion: @escaping () -> Void)
}



class FavoriteService: FavoriteServiceType {
    
    func favoritesToBasket(completion: @escaping () -> Void) {
        let faboriteItems = realm.objects(FavoriteItem.self)
        
        for object in faboriteItems {
            let exist = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id) != nil
            if exist {
                guard let count = realm.object(ofType: BasketItem.self, forPrimaryKey: object.id)?.count else { return }
                let currenCount = Int(count)! + 1
                let updatingBasketItem = BasketItem(item: object)
                updatingBasketItem.count = "\(currenCount)"
                try! realm.write {
                    realm.add(updatingBasketItem, update: .modified)
                }
                
            } else {
                try! realm.write {
                    realm.add(BasketItem(item: object))
                }
            }
        }
        clearAll {
            completion()
        }
    }
    
    
    func clearAll(completion: @escaping () -> Void) {
        let items = realm.objects(FavoriteItem.self)
        try! realm.write {
            realm.delete(items)
            completion()
        }
    }
    
    static func isEmpty() -> Bool {
        return realm.objects(Output.self).count > 0 ? false : true
    }
}



//MARK: RealmGRUDServiseType

extension FavoriteService: RealmGRUDType {
    
    
    typealias Input = Goods
    typealias Output = FavoriteItem
    
    static func create(object: Goods, completion: @escaping () -> Void) {
        print(#function)
        let exist = realm.object(ofType: FavoriteItem.self, forPrimaryKey: object.id) != nil
        if exist {
            completion()
        } else {
            try! realm.write {
                realm.add(FavoriteItem(goods: object))
                completion()
            }
        }
    }
    
    static func read(id: String, completion: @escaping (FavoriteItem?) -> Void) {
        guard let item = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
        completion(item)
    }
    
    static func update(object: FavoriteItem, completion: @escaping () -> Void) {
        print(#function)
        completion()
    }
    
    static func delete(id: String, completion: @escaping () -> Void) {
    
        guard let favoriteItem = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
        try! realm.write {
            realm.delete(favoriteItem)
            completion()
        }
    }
}
