//
//  MultipleInharitance.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 22.04.2022.
//

import Foundation


protocol Flyable {
    func fly()
}

protocol Crawlable {
    func crawl()
}

class Bird: Flyable {
    func fly() {
        
    }
}

class Lizzard: Crawlable {
    func crawl() {
        
    }
}

class Dragon: Flyable, Crawlable {
    private let bird = Bird()
    private let lizzard = Lizzard()
    
    func fly() {
        bird.fly() // delegation
    }
    
    func crawl() {
        lizzard.crawl()
    }
}
