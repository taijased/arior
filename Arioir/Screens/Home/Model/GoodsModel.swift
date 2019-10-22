//
//  GoodsModel.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 15.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import RealmSwift


class Goods: Object {
    @objc dynamic var id: String?
    @objc dynamic var price: String?
    @objc dynamic var oldprice: String?
    @objc dynamic var currencyId: String?
    @objc dynamic var categoryId: String?
    @objc dynamic var picture: String?
    @objc dynamic var vendor: String?
    @objc dynamic var vendorCode: String?
    @objc dynamic var name: String?
    
    // name desc becouse description mistake
    @objc dynamic var desc: String?
    @objc dynamic var sales_notes: String?
    @objc dynamic var country_of_origin: String?
    let params = List<FilterParam>()
    
    convenience init(id: String?, picture: String?, name: String?) {
        self.init()
        self.id = id
        self.name = name
        self.picture = picture
    }
    
    convenience init(offer: Offer) {
        self.init()
        self.id = offer.id
        self.price = offer.price
        self.oldprice = offer.oldprice
        self.currencyId = offer.currencyId
        self.categoryId = offer.categoryId
        self.vendor = offer.vendor
        self.vendorCode = offer.vendorCode
        self.name = offer.name
        self.desc = offer.description
        self.picture = offer.picture
        self.sales_notes = offer.sales_notes
        self.country_of_origin = offer.country_of_origin
        
        offer.params?.forEach({ (param) in
            self.params.append(FilterParam(param: param))
        })
        
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


class FilterParam: Object {
    @objc dynamic var name: String?
    @objc dynamic var value: String?
    convenience init(param: Param) {
        self.init()
        self.name = param.name
        self.value = param.value
    }

}
