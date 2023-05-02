//
//  SearchbarView.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search by pokemon name", text: $searchTerm)
                .foregroundColor(.primary)
            
            if !searchTerm.isEmpty {
                Button(action: {
                    self.searchTerm = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}
struct SearchbarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchTerm: .constant(""))
    }
}
