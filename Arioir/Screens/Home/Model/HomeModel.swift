//
//  HomeModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



enum HomeNavigation {
    case filtres
    case favorites
    case favoritesEmpty(errorTitle: String)
    case basket
    case basketEmpty(errorTitle: String)
    case arScene
    case disconnect
    case dissmis
}
