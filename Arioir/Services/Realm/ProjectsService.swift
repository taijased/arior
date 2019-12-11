//
//  ProjectsService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import RealmSwift


protocol ProjectsServiceType {
    static func addDefaultProject(completion: @escaping () -> Void)
    static func clearAll(completion: @escaping () -> Void)
    static func isEmpty() -> Bool
    static func addNewProjectItem(projectId: String, projectItem: Goods, completion: @escaping () -> Void)
}

class ProjectsService: ProjectsServiceType {
    
    
    
    static func addNewProjectItem(projectId: String, projectItem: Goods, completion: @escaping () -> Void) {
        
        guard let item = realm.object(ofType: Project.self, forPrimaryKey: projectId) else { return }
        
        let exist = item.goods.contains(projectItem)
        if exist {
            completion()
        } else {
            try! realm.write {
                item.goods.append(projectItem)
                completion()
            }
        }
    }
    
    
    
    static func deleteProjectItem(projectId: String, elementId: String, completion: @escaping () -> Void) {
        guard
            let item = realm.object(ofType: Project.self, forPrimaryKey: projectId),
            let element = realm.object(ofType: Goods.self, forPrimaryKey: elementId)
        else { return }
        
        try! realm.write {
            if let index = item.goods.index(of: element) {
                item.goods.remove(at: index)
            }
            completion()
        }

    }
    
    
    
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

extension ProjectsService: RealmGRUDType {
    
    typealias Input = Goods
    typealias Output = Project
    
    static func create(object: Goods, completion: @escaping () -> Void) {
        try! realm.write {
            realm.add(object)
            completion()
        }
    }
    
    static func create(id: String, completion: @escaping () -> Void) {
        
        let exist = realm.object(ofType: ProjectItem.self, forPrimaryKey: id) != nil
        guard let item = realm.object(ofType: Goods.self, forPrimaryKey: id) else { return }
        if exist {
            completion()
        } else {
            try! realm.write {
                realm.add(ProjectItem(goods: item))
                completion()
            }
        }
    }
    
    static func read(id: String, completion: @escaping (Project?) -> Void) {
        guard let item = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
        completion(item)
    }
    
    
    //this is bullshit
    static func update(object: Project, completion: @escaping () -> Void) {
        print(#function)
    }
    
    static func delete(id: String, completion: @escaping () -> Void) {

        guard let item = realm.object(ofType: ProjectItem.self, forPrimaryKey: id) else { return }
        try! realm.write {
            realm.delete(item)
            completion()
        }
    }

    static func delete(projectId: String, completion: @escaping () -> Void) {

       guard let item = realm.object(ofType: Project.self, forPrimaryKey: projectId) else { return }
       try! realm.write {
           realm.delete(item)
           completion()
       }
    }
    
    
}
