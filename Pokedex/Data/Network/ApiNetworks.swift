//
//  ApiNetworks.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import Foundation

protocol ApiService {
    
    func getFirstPokemons() async throws -> PokemonList
    
    func getPokemon(pokemon: String) async throws -> PokemonDetails
    
    func getPokemonsByType(type: String) async throws -> PokemonTypeResponse
    
}


class ApiServiceImpl: ApiService {
    
    func getFirstPokemons() async throws -> PokemonList {
        let path = "pokemon"
        
        guard let url = URL(string: Constants.globalUrl + path) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(PokemonList.self, from: data)
    }
    
    func getPokemon(pokemon: String) async throws -> PokemonDetails {
        let path = "pokemon/\(pokemon)/"
        
        guard let url = URL(string: Constants.globalUrl  + path) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(PokemonDetails.self, from: data)
    }
    
    func getPokemonsByType(type: String) async throws -> PokemonTypeResponse {
        let path = "type/\(type)/"
        
        guard let url = URL(string: Constants.globalUrl  + path) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(PokemonTypeResponse.self, from: data)
    }
}
