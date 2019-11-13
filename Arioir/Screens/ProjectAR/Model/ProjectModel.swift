//
//  ProjectModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import RealmSwift


class Project: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var iconName: String?
    var goods = List<Goods>()
    
    
    convenience init(id: String, name: String, iconName: String) {
        self.init()
        self.id = id
        self.name = name
        self.iconName = iconName
    }
    
    convenience init(id: String, name: String, iconName: String, goods: List<Goods>) {
        self.init()
        self.id = id
        self.name = name
        self.iconName = iconName
        self.goods = goods
    }
    convenience init(project: Project) {
        self.init()
        self.id = project.id
        self.name = project.name
        self.iconName = project.iconName
        self.goods = project.goods
    }
       
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}



class ProjectItem: Object {
    @objc dynamic var id: String?
    @objc dynamic var goods: Goods?

    convenience init(goods: Goods) {
        self.init()
        self.id = goods.id
        self.goods = goods
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
