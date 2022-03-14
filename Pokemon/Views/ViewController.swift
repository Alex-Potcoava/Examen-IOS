//
//  ViewController.swift
//  Pokemon
//
//  Created by Miguel Estévez.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var pokemonList: PokemonList?
    var connection = Connection()
    var pokemons: [Pokemon?] = []
    var images: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alpha = 0.0
        title = "List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        downloadPokemonList()
    }
    
    // MARK: - UITableView delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        cell.pokemonNameLabel.text = pokemonList?.results[indexPath.row].name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController, let indexPath = sender as? IndexPath {
                detailVC.pokemonUrl = pokemonList?.results[indexPath.row].url
                detailVC.pokemonName = pokemonList?.results[indexPath.row].name.capitalized
            }
        }
    }
    
    func downloadPokemonList(){
        
        let connection = Connection()
        
        connection.getPokemonList(){
            
            pokemons in
            
            if let pokemonList = pokemons {
                
                DispatchQueue.main.async{
                    
                    self.pokemonList = pokemons
                    self.tableView.reloadData()
                    self.tableView.alpha = 1.0
                }
            }else{
                print("Error la lista no es correcta")
            }
        }
    }
}


