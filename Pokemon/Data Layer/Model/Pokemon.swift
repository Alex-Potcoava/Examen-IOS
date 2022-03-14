//
//  Pokemon.swift
//  Pokemon
//
//  Created by Miguel Estévez on 10/02/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import Foundation

class Pokemon: Mappable {
    var id: Int?
    var order: Int?
    var name: String?
    var sprites: Sprite?
    var battleOnly: Bool?
    var isDefault: Bool?
    var isMega: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case battleOnly = "is_battle_only"
        case isDefault = "is_default"
        case isMega = "is_mega"
        case id
        case order
        case name
        case sprites
    }
}
