//
//  MethodChain.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 30.04.2022.
//

import Foundation


class Personage: CustomStringConvertible {
    var name: String
    var attack: Int
    var defense: Int
    
    init(name: String, attack: Int, defense: Int) {
        self.name = name
        self.attack = attack
        self.defense = defense
    }
    
    var description: String {
        return "Name is \(name), attack: \(attack), defense: \(defense)"
    }
}

class CharacterModifier {
    let character: Personage
    var next: CharacterModifier?
    
    init(character: Personage) {
        self.character = character
    }
    
    func add(_ cm: CharacterModifier) {
        if let next = next {
            next.add(cm)
        } else {
            next = cm
        }
    }
    
    func handle() {
        next?.handle()
    }
}

class DoubleAttackModifier: CharacterModifier {
    override func handle() {
        print("Doubling \(character.name)")
        character.attack *= 2
        super.handle()
    }
}

class IncreaseDefenseModifier: CharacterModifier {
    override func handle() {
        print("Increasing \(character.name)'s defense")
        character.defense += 3
        super.handle()
    }
}

class NoBonusesModifier: CharacterModifier {
    override func handle() {
        // nothing
    }
}

func methodChain() {
    let goblin = Personage(name: "Goblin", attack: 2, defense: 2)
    print(goblin)
    
    let root = CharacterModifier(character: goblin)
    root.add(NoBonusesModifier(character: goblin))
    print("Let's double a goblin attack!")
    root.add(DoubleAttackModifier(character: goblin))
    print("Let's inrease a goblin defense!")
    root.add(IncreaseDefenseModifier(character: goblin))
    root.handle()
    print(goblin)
}
