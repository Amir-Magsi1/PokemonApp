//
//  ContentView.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import SwiftUI

// MARK: - App Entry Point
struct ContentView: View {
    
    @ObservedObject var viewModel: PokemonsViewModel = .init()
    @State private var showNewPokemonView = false
    @State private var showPokemonDetailView = false
    @State private var detailModel: PokemonModel?
    
    let columns = [
        GridItem(.flexible(minimum: 1.0/2)),
        GridItem(.flexible(minimum: 1.0/2))
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Pokédex")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.appColor)
                    Text("Search for a pokemon by name")
                        .font(.callout)
                }
                .padding(.bottom)
                SearchBarView(searchTerm: $viewModel.searchText)
                    .padding(.bottom)
                filterOptionsView()
                Spacer()
                if viewModel.filterTypes.isEmpty {
                    withAnimation {
                        noResultsView()
                    }
                }else {
                    pokemonListView()
                        .padding(.top)
                }
            }
            
            addButton()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .padding()
        .padding([.leading,.trailing], 8)
        .sheet(isPresented: $showNewPokemonView) {
            NewPokemonView(isPresented: $showNewPokemonView,
                           onAddNewPokemon: { model in
                DispatchQueue.main.async {            
                    viewModel.addNewPokemon(model)
                }
            })
        }
        .sheet(item: $detailModel) { pokemon in
            PokemonDetailView(pockemonModel: pokemon)
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    fileprivate func noResultsView() -> some View {
        return VStack {
            Text("No results found")
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
    }
    
    fileprivate func pokemonListView() -> some View {
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.filterPokemons(), id: \.id) { pockemon in
                    PokemonCard(pockemonModel: pockemon)
                        .frame(height: 200)
                        .onTapGesture {
                            self.detailModel = pockemon
                            showPokemonDetailView = true
                        }
                }
            }
        }
    }
    
    fileprivate func filterOptionsView() -> some View {
        return ScrollView(.horizontal,
                          showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.filterTypes, id: \.self) { option in
                    Button(action: {
                        withAnimation {
                            DispatchQueue.main.async {
                                viewModel.selectedFilter = option
                            }
                        }
                    }) {
                        Text(option)
                            .padding()
                            .cornerRadius(10)
                            .background(viewModel.selectedFilter == option ? Color.appColor : Color.gray)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxHeight: 30)
        }
    }
    
    fileprivate func addButton() -> some View {
        return VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showNewPokemonView.toggle()
                }, label: {
                    Text("+")
                        .font(.system(.largeTitle))
                        .frame(width: 77, height: 70)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                })
                .background(Color.appColor)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
