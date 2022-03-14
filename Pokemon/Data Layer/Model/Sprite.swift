//
//  Sprite.swift
//  Pokemon
//
//  Created by Miguel Estévez on 10/02/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import Foundation

class Sprite: Mappable {
    var backdefault: String?
    var frontdefault: String?
    
    private enum CodingKeys: String, CodingKey{
        case frontdefault = "front_default"
        case backdefault = "back_default"
    }
}
