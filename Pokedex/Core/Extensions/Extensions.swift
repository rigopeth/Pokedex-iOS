//
//  Extensions.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import Foundation

extension PokemonType {
    var uiType: PokemonTypeUI? {
        PokemonTypeUI(rawValue: name)
    }
}
