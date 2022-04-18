//
//  Bridge.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 18.04.2022.
//

import Foundation

protocol Renderer {
    func renderCircle(_ radius: Float)
}

class VectorRenderer : Renderer {
    
    func renderCircle(_ radius: Float) {
        print("Drawing a circle or radius \(radius)")
    }
    
}

class RasterRenderer : Renderer {
    
    func renderCircle(_ radius: Float) {
        print("Drawing pixels for circle of radius \(radius)")
    }
    
}

protocol Shape {
    func draw()
    func resize(_ factor: Float)
}

class Circle : Shape {
    var radius: Float
    var renderer: Renderer

    init(_ renderer: Renderer, _ radius: Float) {
        self.renderer = renderer
        self.radius = radius
    }

    func draw() {
      renderer.renderCircle(radius)
    }

    func resize(_ factor: Float) {
      radius *= factor
    }
}

func bridge() {
    let raster = RasterRenderer()
    let vector = VectorRenderer()
      
    let circle1 = Circle(vector, 5)
    circle1.draw()
    circle1.resize(2)
    circle1.draw()
      
    let circle2 = Circle(raster, 10)
    circle2.draw()
    circle2.resize(2)
    circle2.draw()
}


