//
//  ProjectItemService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import RealmSwift


protocol ProjectItemServiceType {
    static func addDefaultProject(completion: @escaping () -> Void)
    static func clearAll(completion: @escaping () -> Void)
    static func isEmpty() -> Bool
}

class ProjectItemService: ProjectItemServiceType {
    
    
    static func clearAll(completion: @escaping () -> Void) {
        let items = realm.objects(Output.self)
        try! realm.write {
            realm.delete(items)
            completion()
        }
    }
    
    static func isEmpty() -> Bool {
        return realm.objects(Output.self).count > 0 ? false : true
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
}



//MARK: RealmGRUDServiseType

extension ProjectItemService: RealmGRUDType {
    
    typealias Input = Goods
    typealias Output = ProjectItem
    
    static func create(object: Goods, completion: @escaping () -> Void) {
        let exist = realm.object(ofType: Goods.self, forPrimaryKey: object.id) != nil
        if exist {
            completion()
        } else {
            try! realm.write {
                realm.add(FavoriteItem(goods: object))
                completion()
            }
        }
    }
    
    static func read(id: String, completion: @escaping (ProjectItem?) -> Void) {
        guard let item = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
        completion(item)
    }
    
    static func update(object: ProjectItem, completion: @escaping () -> Void) {
        print(#function)
    }
    
    static func delete(id: String, completion: @escaping () -> Void) {
        guard let item = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
        
        try! realm.write {
            realm.delete(item)
            completion()
        }
    }
}
