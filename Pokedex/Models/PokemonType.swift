//
//  PokemonType.swift
//  Pokédex
//
//  Created by Amir Hussain on 08/02/2023.
//

import Foundation

enum PokemonType: String, CaseIterable {
    case Bug = "BUG"
    case Dark = "DARK"
    case Dragon = "DRAGON"
    
    case Electric = "ELECTRICT"
    case Fairy = "FAIRY"
    case Fighting = "FIGHTING"
    
    case Fire = "FIRE"
    case Flying = "FLYING"
    case Ghost = "GHOST"
    
    case Grass = "GRASS"
    case Ground = "GROUND"
    case Ice = "ICE"
    
    case Normal = "NORMAL"
    case Poison = "POISON"
    case Pyschic = "PYSCHIC"
    
    case Rock = "ROCK"
    case Steel = "STEEL"
    case Water = "WATER"
    
    static var types: [String] {
        get {
            PokemonType.allCases.compactMap({ $0.rawValue })
        }
    }
    
    static var typesWithAll: [String] {
        get {
            var strings =  PokemonType.allCases.compactMap({ $0.rawValue })
            strings.insert("All", at: .zero)
            return strings
        }
    }
}
