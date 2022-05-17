//
//  Planet.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import Foundation

public struct PlanetApiResult : Codable {
    var count : Int
    var next : String
    var previous : String?
    var results : [Planet]
}

public struct Planet : Codable, Identifiable {
    public let id = UUID()

    var name : String
    
    enum CodingKeys : CodingKey {
        case name
    }
}
