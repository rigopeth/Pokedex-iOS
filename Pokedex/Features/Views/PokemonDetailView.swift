//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    
    let pokemon : String
    let onTypeSelected: (String) -> Void
    @StateObject  private var viewModel = PokemonViewModel()
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else if let pokemonDetails = viewModel.pokemonDetails {
                VStack {
                    Text(pokemonDetails.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        KFImage(URL(string: pokemonDetails.sprites.frontDefault))
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        KFImage(URL(string: pokemonDetails.sprites.frontShiny))
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    
                    Text("ID: \(pokemonDetails.id)")
                        .font(.headline)
                    
                    HStack(spacing: 8) {
                        let sortedTypes = pokemonDetails.types.sorted { $0.slot < $1.slot }
                        
                        ForEach(sortedTypes, id: \.slot) { slot in
                            Button {
                                let selectedType = slot.type.name
                                onTypeSelected(selectedType)
                                dismiss()
                            } label: {
                                if let uiType = slot.type.uiType {
                                    PokemonTypeBadge(type: uiType)
                                } else {
                                    Text(slot.type.name.capitalized)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Stats")
                            .font(.headline)
                        
                        ForEach(pokemonDetails.stats, id: \.stat.name) { stat in
                            StatBarView(name: stat.stat.name, value: stat.baseStat)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle(pokemon.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task(id: pokemon) {
            await viewModel.getPokemonDetail(pokemon: pokemon)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: "celebi") { _ in }
}
