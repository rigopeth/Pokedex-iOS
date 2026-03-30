//
//  PokemonTypeBadge.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import SwiftUI

struct PokemonTypeBadge: View {
    let type: PokemonTypeUI
    
    var body: some View {
        Text(type.displayName)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(type.color)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

#Preview {
    PokemonTypeBadge(type: .psychic)
}
