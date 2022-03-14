//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Miguel Estévez on 12/03/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemonUrl: String?
    var pokemonName: String?
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var battleSwitch: UISwitch!
    @IBOutlet var defaultSwitch: UISwitch!
    @IBOutlet var megaSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokèmon"
        pokemonNameLabel.text = pokemonName
        
        getPokemon()
    }
    
    func getPokemon() {
        guard let urlString = pokemonUrl else { return }
        
        Connection().getPokemon(fromUrl: urlString) {
            pokemon in
            
            if let pokemon = pokemon {
                Connection().getSprite(with: pokemon.sprites?.frontdefault ?? "") {
                    image in
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                        self.battleSwitch.isOn = pokemon.battleOnly ?? false
                        self.defaultSwitch.isOn = pokemon.isDefault ?? false
                        self.megaSwitch.isOn = pokemon.isMega ?? false
                        
                        if let isBattle = pokemon.battleOnly{
                            self.battleSwitch.isOn = isBattle
                            if isBattle{
                                self.view.backgroundColor = .lightGray
                            }
                        }
                        
                    }
                }
            }
            else {
                // Notify user an error occured
            }
        }
    }
}
