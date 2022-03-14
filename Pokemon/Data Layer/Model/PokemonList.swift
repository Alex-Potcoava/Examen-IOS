//
//  PokemonList.swift
//  Pokemon
//
//  Created by Miguel Estévez.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import Foundation

class PokemonList: Mappable {
    
    class Item: Mappable {
        var name: String = ""
        var url: String = ""
    }
    
    var results = [Item]()
    
}
