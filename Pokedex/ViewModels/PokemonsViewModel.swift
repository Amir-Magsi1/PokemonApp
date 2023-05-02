//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import Foundation
class PokemonsViewModel: NSObject, ObservableObject {
   
    @Published var pokemons: [PokemonModel] = []
    
    @Published var searchText: String = ""
    @Published var filterTypes: [String] = PokemonType.typesWithAll
    @Published var selectedFilter: String = "All"
    
    var isSearching: Bool {
        !searchText.isEmpty || selectedFilter != "All"
    }
    
    private let pokemonsJsonFieName: String = "Pokemons.json"
    
    override init() {
        super.init()
        self.loadAllPokemons()
    }
    
    func filterPokemons() -> [PokemonModel] {
        let searchTerm = searchText.trimmingCharacters(in: .whitespaces)
        let filteredPokemons = pokemons.filter { pokemon in
            if searchTerm.isEmpty && selectedFilter == "All" {
                return true
            }
            
            if selectedFilter == "All" && !searchTerm.isEmpty {
                return pokemon.name.lowercased().contains(searchTerm.lowercased())
            }
            
            if selectedFilter != "All" && searchTerm.isEmpty {
                return pokemon.type == selectedFilter
            }
            
            
            var doesNameMatch = false
            var doesTypeMatch = false
            doesNameMatch = pokemon.name.lowercased().contains(searchTerm.lowercased())
            doesTypeMatch = pokemon.type == selectedFilter
            return doesNameMatch && doesTypeMatch
        }
        return filteredPokemons
    }
    
    func addNewPokemon(_ model: PokemonModel) {
        self.pokemons.insert(model, at: .zero)
        self.savePokemon(model: model)
    }
    
    fileprivate func savePokemon(model: PokemonModel) {
        do {
            try StorageHelper.store(pokemons, to: .caches, as: pokemonsJsonFieName)
        }catch {
            print("Error saving pokemons", error)
        }
    }
    
    fileprivate func loadAllPokemons() {
        do {
            self.pokemons = try StorageHelper.retrieve(pokemonsJsonFieName, from: .caches, as: [PokemonModel].self)
        }catch {
            print("Error retrieving pokemons", error)
        }
    }

}
