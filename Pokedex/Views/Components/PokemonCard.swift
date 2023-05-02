//
//  PokemonCar.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import SwiftUI

struct PokemonCard: View {
    let pockemonModel: PokemonModel
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageName = pockemonModel.imageName,
               let image = FileManagerHelper.loadImageFromDocuments(name: imageName){
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: .infinity,
                           minHeight: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }else {
                Image("1")
                    .resizable()
                    .frame(maxWidth: .infinity,
                           maxHeight: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            
            Text(pockemonModel.name)
                .font(.headline)
                .padding(.top)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding(10)
        .background(Color.appColor)
        .cornerRadius(10)
    }
}

struct PokemonCar_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pockemonModel: .mockModel)
    }
}
