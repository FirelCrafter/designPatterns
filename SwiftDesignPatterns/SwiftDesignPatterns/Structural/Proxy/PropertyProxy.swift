//
//  PropertyProxy.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 30.04.2022.
//

import Foundation

class Property<T: Equatable> {
    private var _value: T
    
    public var value: T {
        get { return _value }
        set(value) {
            if value == _value { return }
            print("Setting value to \(value)")
            _value = value
        }
    }
    
    init(_ value: T) {
        _value = value
    }
}

func == <T>(lhs: Property<T>, rhs: Property<T>) -> Bool {
    return lhs.value == rhs.value
}

class Creature {
    private let _agility = Property<Int>(0)
    var agility: Int {
        get { return _agility.value }
        set(value) { _agility.value = value }
    }
}

func propertyProxy() {
    let c = Creature()
    c.agility = 10
    
    print(c.agility)
}

extension Property: Equatable {
    
}
