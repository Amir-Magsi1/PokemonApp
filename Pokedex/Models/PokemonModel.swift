//
//  PokemonModel.swift
//  Pokédex
//
//  Created by Amir Hussain on 08/02/2023.
//

import Foundation

struct PokemonModel: Codable, Identifiable {
    var id: UUID = .init()
    let name: String
    let description: String
    let imageName: String?
    let type: String
}

extension PokemonModel {
    static let mockModel: PokemonModel = .init(name: "Pickcho",
                                           description: "It is cute buddy",
                                           imageName: "",
                                           type: "Water")
    static let mockModel1: PokemonModel = .init(name: "Pickcho",
                                           description: "It is cute buddy",
                                           imageName: "",
                                           type: "Water")
}
