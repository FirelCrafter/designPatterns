//
//  Singleton.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 17.04.2022.
//

import Foundation

class SingletonDatabase {
    
    var capitals: [Capital]
    static var instanceCount = 0
    
    static let shared = SingletonDatabase(CAPITALS)
    
    private init(_ capitals: [Capital]) {
        self.capitals = capitals
        type(of: self).instanceCount += 1
        print("Init of Database")
    }
    
    func getCitiesList() -> [String] {
        return self.capitals.map({$0.name})
    }
    
    func getPostalCode(_ name: String) -> Int {
        return self.capitals.first(where: {$0.name == name})?.postalCode ?? 0
    }
}
