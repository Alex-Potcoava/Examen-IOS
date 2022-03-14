//
//  Connection.swift
//  Pokemon
//
//  Created by Miguel Estévez.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import UIKit

class Connection {
    let baseUrlString = "https://pokeapi.co/api/v2/pokemon-form/?offset=203&limit=20"
    
    func getPokemonList(completion: @escaping (_ pokemonList: PokemonList?) -> Void) {
        guard let url = URL(string: baseUrlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async {
                let pokemonList = PokemonList(withJsonData: data)
                completion(pokemonList)
            }
        }
        task.resume()
    }
    
    func getPokemon(fromUrl urlString: String, method: String = "GET", params: [AnyHashable: Any]? = nil, completion: @escaping (_ pokemon: Pokemon?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = method
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])
        
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            if error == nil {
                let pokemon = Pokemon(withJsonData: data)
                completion(pokemon)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getPokemon(withId id: Int, method: String = "GET", params: [AnyHashable: Any]? = nil, completion: @escaping (_ pokemon: Pokemon?) -> Void  ) {
        getPokemon(fromUrl: baseUrlString + "\(id)/", method: method, params: params, completion: completion)
    }
    
    func getSprite(with urlString: String, completion: @escaping (_ sprite: UIImage?) -> Void) {
        // Stub method
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = urlSession.dataTask(with: url){
            data, response, error in
            
            if(response as! HTTPURLResponse).statusCode == 200{
                if error == nil , let data = data{
                    completion(UIImage(data: data))
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}

