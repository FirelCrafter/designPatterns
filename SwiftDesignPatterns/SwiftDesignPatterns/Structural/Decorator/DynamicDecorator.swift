//
//  DynamicDecorator.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 22.04.2022.
//

import Foundation

protocol DecoratorShape: CustomStringConvertible {
    init()
    var description: String { get }
}

class DecoratorCircle: DecoratorShape {
    
    required init() {
        
    }

    private var radius: Float = 0
    
    init(_ radius: Float) {
        self.radius = radius
    }
    
    func resize(_ factor: Float) {
        radius *= factor
    }
    
    var description: String {
        return "The circle of raduis \(radius)"
    }
}

class DecoratorSquare: DecoratorShape {
    required init() {
        
    }
    
    private var side: Float = 0
    
    init(_ side: Float) {
        self.side = side
    }
    
    var description: String {
        return "Square with side \(side)"
    }
}

class DecoratorColoredShape<T>: DecoratorShape where T: DecoratorShape {
    
    private var color = "black"
    private var shape: T = T()
    
    required init() {
        
    }
    
    init(_ color: String) {
        self.color = color
    }
    
    var description: String {
        return "\(shape) has color \(color)"
    }
}

class DecoratorTransparentShape<T>: DecoratorShape where T: DecoratorShape {
    
    
    private var transparency: Float = 0
    private var shape: T = T()
    
    required init() { }
    
    init(_ transparency: Float) {
        self.transparency = transparency
    }
    
    var description: String {
        return "\(shape) has \(transparency * 100)% transparency"
    }
}

//MARK: Summary

/// Decorator keeps reference to the decorated object(s)
/// May or may not proxy over calls
/// Exists in a stattic varation

/*
 protocol DecoratorShape: CustomStringConvertible {
     var description: String { get }
 }

 class DecoratorCircle: DecoratorShape {
     
     
     private var radius: Float = 0
     
     init(_ radius: Float) {
         self.radius = radius
     }
     
     func resize(_ factor: Float) {
         radius *= factor
     }
     
     var description: String {
         return "The circle of raduis \(radius)"
     }
 }

 class DecoratorSquare: DecoratorShape {
     
     private var side: Float = 0
     
     init(_ side: Float) {
         self.side = side
     }
     
     var description: String {
         return "Square with side \(side)"
     }
 }

 class DecoratorColoredShape: DecoratorShape {
     
     var shape: DecoratorShape
     var color: String
     
     init(_ shape: DecoratorShape, _ color: String) {
         self.shape = shape
         self.color = color
     }
     
     var description: String {
         return "\(shape) has color \(color)"
     }
 }

 class DecoratorTransparentShape: DecoratorShape {
     
     var shape: DecoratorShape
     var transparency: Float
     
     init(_ shape: DecoratorShape, _ transparency: Float) {
         self.shape = shape
         self.transparency = transparency
     }
     
     var description: String {
         return "\(shape) has \(transparency * 100)% transparency"
     }
 }
 */ // Dynamic Decorator is here

func dynamicDecorator() {
    let blueCircle = DecoratorColoredShape<DecoratorCircle>("blue")
    print(blueCircle)
    
    let blackHalfSquare = DecoratorTransparentShape<DecoratorColoredShape<DecoratorSquare>>(0.4)
    print(blackHalfSquare)
}
