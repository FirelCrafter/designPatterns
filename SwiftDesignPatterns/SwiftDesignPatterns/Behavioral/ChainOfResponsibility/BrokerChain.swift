//
//  BrokerChain.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 30.04.2022.
//

import Foundation

protocol Invocable: AnyObject {
    func invoke(_ data: Any)
}

public protocol Disposable {
    func dispose()
}

public class Event<T> {
    
    public typealias EventHandler = (T) -> ()
    
    var eventHandlers = [Invocable]()
    
    public func raise(_ data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data)
        }
    }
    
    public func addHandler<U: AnyObject>(target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
        let subscription = Subscription(target: target, handler: handler, event: self)
        eventHandlers.append(subscription)
        return subscription
    }
}

class Subscription<T: AnyObject, U>: Invocable, Disposable {
    
    weak var target: T?
    let handler: (T) -> (U) -> ()
    let event: Event<U>
    
    init(target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event
    }
    
    func invoke(_ data: Any) {
        if let target = target {
            handler(target)(data as! U)
        }
    }
    
    func dispose() {
        event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject? !== self }
    }
}

class Query {
    
    var creatureName: String
    enum Argument {
        case attack, defense
    }
    var whatToQuery: Argument
    var value: Int
    
    init(name: String, whatToQuery: Argument, value: Int) {
        self.creatureName = name
        self.whatToQuery = whatToQuery
        self.value = value
    }
}

class Game {
    let queries = Event<Query>()
    
    func performQuery(query: Query) {
        queries.raise(query)
    }
}

class BrokenChainCreature: CustomStringConvertible {
    var name: String
    private let _attack, _defense: Int
    private let game: Game
    
    init(game: Game, name: String, attack: Int, defense: Int) {
        self.game = game
        self.name = name
        _attack = attack
        _defense = defense
    }
    
    var attack: Int {
        let q = Query(name: name, whatToQuery: .attack, value: _attack)
        game.performQuery(query: q)
        return q.value
    }
    
    var defense: Int {
        let q = Query(name: name, whatToQuery: .defense, value: _defense)
        game.performQuery(query: q)
        return q.value
    }
    
    var description: String {
        return "Name: \(name), attack: \(attack), defense: \(defense)"
    }
}

class CreatureModifier: Disposable {
    let game: Game
    let creature: BrokenChainCreature
    var event: Disposable? = nil
    
    init(game: Game, creature: BrokenChainCreature) {
        self.game = game
        self.creature = creature
        event = self.game.queries.addHandler(target: self, handler: CreatureModifier.handle)
    }
    
    func handle(_ q: Query) {
        
    }
    
    
    func dispose() {
        event?.dispose()
    }
}

class DoubleAttackModifier2: CreatureModifier {
    override func handle(_ q: Query) {
        if q.creatureName == creature.name && q.whatToQuery == .attack {
            q.value *= 2
        }
    }
}

class IncreaseDefenseModifier2: CreatureModifier {
    override func handle(_ q: Query) {
        if q.creatureName == creature.name && q.whatToQuery == .defense {
            q.value += 2
        }
    }
}

func brokerChain() {
    let game = Game()
    let goblin = BrokenChainCreature(game: game, name: "Strong goblin", attack: 3, defense: 3)
    print("Baseline goblin: \(goblin)")
    
    let dam = DoubleAttackModifier2(game: game, creature: goblin)
    print("Goblin with x2 attack: \(goblin)")
    
    let idm = IncreaseDefenseModifier2(game: game, creature: goblin)
    print("Defensed goblin: \(goblin)")
    
    idm.dispose()
    dam.dispose()
    print("Bonuses left \(goblin)")
}
