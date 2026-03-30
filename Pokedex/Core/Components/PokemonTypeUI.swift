//
//  PokemonTypeUI.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import Foundation
import SwiftUI

enum PokemonTypeUI: String {
    case normal,fire,water,electric,grass,ice
    case fighting, poison, ground, flying
    case psychic, bug, rock, ghost, dragon
    case dark, steel, fairy
    
    var color: Color {
        switch self {
        case .fire: return .red
        case .water: return .blue
        case .grass: return .green
        case .electric: return .yellow
        case .psychic: return .purple
        case .ice: return .cyan
        case .dragon: return .indigo
        case .dark: return .black
        case .fairy: return .pink
        case .poison: return .purple.opacity(0.7)
        case .ground: return .brown
        case .rock: return .gray
        case .bug: return .green.opacity(0.6)
        case .ghost: return .indigo.opacity(0.7)
        case .steel: return .gray.opacity(0.6)
        case .fighting: return .orange
        case .flying: return .teal
        case .normal: return .gray.opacity(0.4)
        }
    }
        
    var displayName: String {
        rawValue.capitalized
    }
}
