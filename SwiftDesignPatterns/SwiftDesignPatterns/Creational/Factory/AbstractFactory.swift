//
//  AbstractFactory.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 17.04.2022.
//

import Foundation

protocol HotDrink {
    func consume()
}

class Tea: HotDrink {
    func consume() {
        print("This tea is nice, but I'd prefer it with milk")
    }
}

class Coffee: HotDrink {
    func consume() {
        print("This coffee is delicious!")
    }
}

protocol HotDrinkFactory {
    func prepare(_ amount: Int) -> HotDrink
    init()
}

class TeaFactory {
    required init() { }
    func prepare(_ amount: Int) -> HotDrink {
        print("Put in tea bag, boil water, pour \(amount)ml, add lemon and enjoy!")
        return Tea()
    }
}

class CoffeeFactory {
    required init() { }
    func prepare(_ amount: Int) -> HotDrink {
        print("Grind some beans, boil water, pour \(amount)ml, add cream and sugar, enjoy!")
        return Coffee()
    }
}

class HotDrinkMachine {
    enum AvailableDrinks: String, CaseIterable {
        case coffee = "Coffee"
        case tea = "Tea"
    }
    
    internal var factories = [AvailableDrinks: HotDrinkFactory]()
    
    internal var namedFactories = [(String, HotDrinkFactory)]()
    
    init() {
        for drink in AvailableDrinks.allCases {
            let moduleName = Bundle.main.infoDictionary!["CFBundleName"] as! String // will work on real project
            print(moduleName)
            let type: AnyClass? = NSClassFromString("\(moduleName).\(drink.rawValue)Factory")
            if let type = type {
                let factory = (type as! HotDrinkFactory.Type).init()
                factories[drink] = factory
                namedFactories.append((drink.rawValue, factory))
            }
            
        }
    }
    
    func makeDrink() -> HotDrink {
        print("Available drinks")
        for i in 0..<namedFactories.count {
            let tuple = namedFactories[i]
            print("\(i): \(tuple.0)")
        }
        let input = Int(readLine()!)!
        return namedFactories[input].1.prepare(250)
    }
}

func abstractFactory() {
    let machine = HotDrinkMachine()
    print(machine.namedFactories.count)
    let drink = machine.makeDrink()
    drink.consume()
}
