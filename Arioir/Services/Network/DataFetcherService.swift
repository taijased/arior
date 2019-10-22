//
//  DataFetcherService.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



class DataFetcherService {
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    
    func fetchWallpapers(completion: @escaping (YmlCatalog?) -> Void) {
         let urlString = "https://www.demmoksi.ru/bitrix/catalog_export/yandex.php"
         dataFetcher.fetchGenericXMLData(urlString: urlString, response: completion)
     }
    
}
