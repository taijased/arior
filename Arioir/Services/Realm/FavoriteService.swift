//
//  FavoriteGRUDService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 09.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation








protocol RealmGRUDType {
    associatedtype Input
    associatedtype Output
    static func create(object: Input, completion: @escaping () -> Void)
    static func read(id: String, completion: @escaping () -> Output)
    static func update(object: Output, completion: @escaping () -> Void)
    static func delete(id: String, completion: @escaping () -> Void)
}


protocol FavoriteServiceType {
    
    func favoritesToBasket(completion: @escaping () -> Void)
    func clearFavorites(completion: @escaping () -> Void)
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
        clearFavorites {
            completion()
        }
    }
    
    
    func clearFavorites(completion: @escaping () -> Void) {
        let favoriteObjects = realm.objects(FavoriteItem.self)
        try! realm.write {
            realm.delete(favoriteObjects)
            completion()
        }
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
            guard let count = realm.object(ofType: FavoriteItem.self, forPrimaryKey: object.id)?.count else { return }
            let currenCount = Int(count)! + 1
            let updatingFavoriteItem = FavoriteItem(goods: object)
            updatingFavoriteItem.count = "\(currenCount)"
            try! realm.write {
                realm.add(updatingFavoriteItem, update: .modified)
            }
            completion()
        } else {
            try! realm.write {
                realm.add(FavoriteItem(goods: object))
                completion()
            }
        }
    }
    
    static func read(id: String, completion: @escaping () -> FavoriteItem) {
        print(#function)
        completion()
    }
    
    static func update(object: FavoriteItem, completion: @escaping () -> Void) {
        print(#function)
        completion()
    }
    
    static func delete(id: String, completion: @escaping () -> Void) {
        print(#function)
        completion()
    }
}
