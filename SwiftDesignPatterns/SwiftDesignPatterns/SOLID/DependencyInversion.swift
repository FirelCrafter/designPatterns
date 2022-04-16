//
//  DependencyInversion.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 16.04.2022.
//

import Foundation

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person] {
        return relations
            .filter({ $0.name == name && $1 == .parent && $2 === $2 })
            .map({$2})
    }
    // low level module
    
    var relations: [(Person, Relationship, Person)] = []
    
    init() {
        
    }
    
    func addParentAndChild(_ parent: Person, _ child: Person) {
        relations.append((parent, .parent, child))
        relations.append((child, .child, parent))
    }
}

class Research {
    /*
    init(relations: Relationships) {
        let relations = relations.relations
        for r in relations where r.0.name == "John" && r.1 == .parent {
            print("John has a child \(r.2.name)")
        }
    }
    */
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChildrenOf("John") {
            print("John has a child \(p.name)")
        }
    }
}
func dip() {
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")
    
    let relations = Relationships()
    relations.addParentAndChild(parent, child1)
    relations.addParentAndChild(parent, child2)
    
    let _ = Research(relations)
}
