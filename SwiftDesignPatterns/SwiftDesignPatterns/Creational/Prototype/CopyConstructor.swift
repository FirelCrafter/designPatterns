//
//  CopyConstructor.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 17.04.2022.
//

import Foundation

protocol Copying {
    init(copyFrom other: Self)
}

class PrototypeAddress: CustomStringConvertible, Copying {
    
    required init(copyFrom other: PrototypeAddress) {
        streetAddress = other.streetAddress
        city = other.city
    }
    
    var streetAddress: String
    var city: String
    
    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }
    
    var description: String {
        return "\(streetAddress), \(city)"
    }
}

class PrototypeEmployee: CustomStringConvertible, Copying {
    required init(copyFrom other: PrototypeEmployee) {
        name = other.name
        address = PrototypeAddress(copyFrom: other.address)
    }
    
    var name: String
    var address: PrototypeAddress
    
    init(_ name: String, _ address: PrototypeAddress) {
        self.name = name
        self.address = address
    }
    
    var description: String {
        return "My name is \(name), I live at \(address)"
    }
}

func copyConstructor() {
    let john = PrototypeEmployee("John", PrototypeAddress("123 London road", "London"))
    print(john)
    let chris = PrototypeEmployee(copyFrom: john)
    chris.name = "Chris"
    chris.address.streetAddress = "124 London road"
    print(chris)
}
