//
//  PokemonRowView.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import SwiftUI
import Kingfisher

struct PokemonRowView: View {
    let pokemon: Pokemon
    var body: some View {
        HStack (spacing: 16) {
            KFImage(pokemon.imageURL)
                .resizable()
                .retry(maxCount:2, interval: .seconds(1))
                .fade(duration: 0.25)
                .scaledToFit()
                .frame(width: 60, height: 60)
            Text(pokemon.name.capitalized)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PokemonRowView(pokemon: Pokemon(name: "mew", url: "https://pokeapi.co/api/v2/pokemon/151/"))
}
