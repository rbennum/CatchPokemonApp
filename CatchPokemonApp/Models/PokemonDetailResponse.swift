//
//  PokemonDetailResponse.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation
import RealmSwift

class PokemonDetailResponse: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String?
    @Persisted var height: Int?
    @Persisted var weight: Int?
    @Persisted var types = List<PokemonType>()
    @Persisted var stats = List<PokemonStat>()
    @Persisted var sprite: String?
    @Persisted var moves = List<PokemonMove>()
    
    enum OuterKeys: String, CodingKey {
        case name, height, weight, types, stats, moves
        case sprite = "sprites"
    }
    
    enum SpriteKeys: String, CodingKey {
        case imageURL = "front_default"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        
        self.name = try outerContainer.decodeIfPresent(String.self, forKey: .name)
        self.height = try outerContainer.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try outerContainer.decodeIfPresent(Int.self, forKey: .weight)
        let decodedStats = try outerContainer.decodeIfPresent([PokemonStat].self, forKey: .stats)
        self.stats.append(objectsIn: decodedStats ?? [PokemonStat]())
        let decodedTypes = try outerContainer.decodeIfPresent([PokemonType].self, forKey: .types)
        self.types.append(objectsIn: decodedTypes ?? [PokemonType]())
        let decodedMoves = try outerContainer.decodeIfPresent([PokemonMove].self, forKey: .moves)
        self.moves.append(objectsIn: decodedMoves ?? [PokemonMove]())
        
        let spriteContainer = try outerContainer.nestedContainer(keyedBy: SpriteKeys.self, forKey: .sprite)
        self.sprite = try spriteContainer.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OuterKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(height, forKey: .height)
        try container.encode(weight, forKey: .weight)
        try container.encode(stats, forKey: .stats)
        try container.encode(types, forKey: .types)
        try container.encode(moves, forKey: .moves)
        
        var spriteContainer = container.nestedContainer(keyedBy: SpriteKeys.self, forKey: .sprite)
        try spriteContainer.encode(sprite, forKey: .imageURL)
    }
}

class PokemonStat: EmbeddedObject, Codable {
    @Persisted var baseStat: Int?
    @Persisted var statName: String?
    
    enum OuterKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
    
    enum StatKeys: String, CodingKey {
        case name
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let statContainer = try outerContainer.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)
        
        self.baseStat = try outerContainer.decodeIfPresent(Int.self, forKey: .baseStat)
        self.statName = try statContainer.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var outerContainer = encoder.container(keyedBy: OuterKeys.self)
        var statContainer = outerContainer.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)
        
        try outerContainer.encode(baseStat, forKey: .baseStat)
        try statContainer.encode(statName, forKey: .name)
    }
}

class PokemonType: EmbeddedObject, Codable {
    @Persisted var type: String?
    
    enum OuterKeys: String, CodingKey {
        case type
    }
    
    enum TypeKeys: String, CodingKey {
        case name
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let typeContainer = try outerContainer.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        
        self.type = try typeContainer.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var outerContainer = encoder.container(keyedBy: OuterKeys.self)
        var typeContainer = outerContainer.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        
        try typeContainer.encode(type, forKey: .name)
    }
}

class PokemonMove: EmbeddedObject, Codable {
    @Persisted var moveName: String?
    
    enum OuterKeys: String, CodingKey {
        case move
    }
    
    enum MoveKeys: String, CodingKey {
        case moveName = "name"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let moveContainer = try outerContainer.nestedContainer(keyedBy: MoveKeys.self, forKey: .move)
        
        self.moveName = try moveContainer.decodeIfPresent(String.self, forKey: .moveName)
    }
    
    func encode(to encoder: Encoder) throws {
        var outerContainer = encoder.container(keyedBy: OuterKeys.self)
        var moveContainer = outerContainer.nestedContainer(keyedBy: MoveKeys.self, forKey: .move)
        
        try moveContainer.encode(moveName, forKey: .moveName)
    }
}
