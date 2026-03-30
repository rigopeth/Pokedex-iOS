//
//  ContentView.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 28/03/26.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject private var viewModel = PokemonViewModel()
    
    @State private var searchText: String = ""
    @State private var searchMode: SearchMode = .nameOrNumber
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 12){
                // MARK: -Search Section
                HStack(spacing: 12) {
                    
                    HStack(spacing: 8) {
                        TextField( searchMode == .nameOrNumber ? "Search by Name or Number" : "Search by type", text: $searchText)
                    }
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    Button {
                        Task {
                            await perfomSearch()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Picker("Search Mode", selection: $searchMode) {
                    ForEach(SearchMode.allCases){
                        mode in Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // MARK: - List Content
            Group {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                    .padding()
                    Spacer()
                } else {
                    List(viewModel.pokemons) { pokemon in
                        NavigationLink(value: pokemon) {
                            PokemonRowView(pokemon: pokemon)
                                .listRowSeparator(.visible)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Pokemon Search")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon.name) {
                    selectedType in
                    Task {
                        searchMode = .type
                        searchText = selectedType
                        await perfomSearch()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchPokemons()
        }
    }
        
    
    private func perfomSearch() async {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else {
            await viewModel.fetchPokemons()
            return
        }
        
        switch searchMode {
        case .nameOrNumber:
            await viewModel.searchPokemon(pokemon: query)
        case .type:
            await viewModel.pokemonsByType(type: query)
        }
    }
}


#Preview {
    PokemonListView()
}
