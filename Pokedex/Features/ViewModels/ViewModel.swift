//
//  viewModel.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import Foundation
internal import Combine

@MainActor
final class PokemonViewModel: ObservableObject {
    
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var pokemonDetails: PokemonDetails? = nil
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl()) {
        self.apiService = apiService
    }
    
    func fetchPokemons() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await apiService.getFirstPokemons()
            pokemons = response.results
        } catch {
            errorMessage = "Error to fetch pokemons: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func searchPokemon(pokemon: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let pokemon = try await apiService.getPokemon(pokemon: pokemon)
            pokemons.removeAll()
            pokemons.append(Pokemon(name: pokemon.name, url: String(pokemon.id)))
            
        } catch {
            errorMessage = "Error to search pokemon: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func pokemonsByType(type: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await apiService.getPokemonsByType(type: type)
            pokemons.removeAll()
            response.pokemon.forEach { pokemon in
                    pokemons.append(Pokemon(name: pokemon.pokemon.name, url: pokemon.pokemon.url))
            }
        } catch {
            errorMessage = "Error to fetch pokemons by type: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func getPokemonDetail(pokemon:String) async {
        isLoading = true
        errorMessage = nil
        pokemonDetails = nil
        
        do {
            let details = try await apiService.getPokemon(pokemon: pokemon)
            pokemonDetails = details
            
        } catch {
            errorMessage = "Error to fetch pokemon details: \(error.localizedDescription)"
        }
        isLoading = false
        
    }
}
