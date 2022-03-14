//
//  ImageDownloader.swift
//  Pokemon
//
//  Created by Miguel Estévez.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

/*
 ImageDownloader().downloadImage(from: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png") {
     image in
     if let updateCell = tableView.cellForRow(at: indexPath) as? PokemonCell {
         updateCell.pokemonImageView.image = image
     }
 }
 */

import UIKit

class ImageDownloader {

    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!

    init() {
        session = URLSession.shared
        cache = NSCache()
    }

    func downloadImage(from urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let image = self.cache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        }
        else {
            let placeholder: UIImage? = nil
            DispatchQueue.main.async {
                completion(placeholder)
            }
            let url: URL! = URL(string: urlString)
            
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) {
                data, response, error in
                
                if error == nil, let data = data {
                    DispatchQueue.main.async {
                        completion(UIImage(data: data))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
}
