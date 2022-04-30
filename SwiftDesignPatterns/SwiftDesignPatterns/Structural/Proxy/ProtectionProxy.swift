//
//  ProtectionProxy.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 30.04.2022.
//

import Foundation

protocol Vehicle {
    func drive()
}

class Car {
     
    func drive() {
        print("Car is being driven")
    }
}

class CarProxy: Vehicle {
    
    private let car = Car()
    private let driver: Driver
    
    init(driver: Driver) {
        self.driver = driver
    }
    
    func drive() {
        if driver.age >= 16 {
            car.drive()
        } else {
            print("Driver too young")
        }
    }
}

class Driver {
    var age: Int
    init(age: Int) {
        self.age = age
    }
}

func protectionProxy() {
    let car: Vehicle = CarProxy(driver: Driver(age: 12))
    car.drive()
}
