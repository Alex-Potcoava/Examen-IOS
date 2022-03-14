//
//  Session.swift
//  Pokemon
//
//  Created by Miguel Estévez on 10/02/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import Foundation

class Session: Codable {
    static let current = Session()
    private static let kArchiveKey = "ArchiveKey"
    
    var userName: String?
    var token: String?
    
    private init() {
        if let data = UserDefaults.standard.object(forKey: Session.kArchiveKey) as? Data {
            if let savedSession = try? PropertyListDecoder().decode(Session.self, from: data) {
                userName = savedSession.userName
                token = savedSession.token
            }
        }
    }
    
    static func save() {
        if let data = try? PropertyListEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: kArchiveKey)
        }
    }
}
