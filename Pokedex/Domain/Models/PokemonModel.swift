//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 28/03/26.
//

import Foundation

struct PokemonList: Decodable, Sendable {
    let results: [Pokemon]
}

struct Pokemon: Decodable, Sendable, Identifiable, Hashable  {
    var id: String {
        url
    }
    let name: String
    let url: String
    var pokemonId: Int {
        url .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .split(separator: "/")
            .last
            .flatMap { Int($0) } ?? 0
    }
    
    var imageURL: URL? {
        URL(string: Constants.pokemonImageBaseUrl + "\(pokemonId).png")
    }
}

struct PokemonDetails: Decodable, Sendable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [StatInfo]
}

struct Sprites: Decodable, Sendable {
    let frontDefault: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
}

struct PokemonTypeSlot: Decodable, Sendable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable, Sendable {
    let name: String
}

struct StatInfo: Decodable, Sendable {
    let baseStat: Int
    let stat: Stat
     
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat = "stat"
    }
}

struct Stat: Decodable, Sendable {
    let name: String
}

struct PokemonTypeResponse: Decodable, Sendable {
    let pokemon : [PokemonByTypeEntry]
}

struct PokemonByTypeEntry: Decodable, Sendable {
    let pokemon: Pokemon
}


