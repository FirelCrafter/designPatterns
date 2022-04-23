//
//  FlyWeight.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 23.04.2022.
//

import Foundation

/// Flyweight - space optimization technique that lets us user less memoryby storing externally the data asssotiated with similar objects


class User {
    
    var fullname: String
    
    init(_ fullname: String) {
        self.fullname = fullname
    }
    
    var charCount: Int {
        return fullname.utf8.count
    }
    
}

class User2 {
    static var string = [String]()
    private var names = [Int]()
    
    init(_ fullname: String) {
        
        func getOrAdd(_ s: String) -> Int {
            if let idx = type(of: self).string.index(of: s) {
                return idx
            } else {
                type(of: self).string.append(s)
                return type(of: self).string.count - 1
            }
        }
        
        names = fullname.components(separatedBy: " ").map({ getOrAdd($0) })
    }
    
    static var charCount: Int {
        return string.map({ $0.utf8.count }).reduce(0, +)
    }
}

func flyWeight() {
    let user1 = User("John Smith")
    let user2 = User("Jane Smith")
    let user3 = User("Jane Doe")
    let totalChars = user1.charCount + user2.charCount + user3.charCount
    print(totalChars)
    let user4 = User2("John Smith")
    let user5 = User2("Jane Smith")
    let user6 = User2("Jane Doe")
    print("Chars number 2 is \(User2.charCount)")
}
