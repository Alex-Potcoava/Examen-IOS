//
//  Mappable.swift
//  Json1
//
//  Created by Miguel Estévez on 01/01/2012.
//  Copyright © 2012 Miguel Estévez. All rights reserved.
//

import Foundation

protocol Mappable: Codable {
    init?(withJsonData: Data?)
}

extension Mappable {
    init?(withJsonData: Data?) {
        guard let data = withJsonData else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil 
        }
    }
}
