//
//  Facade.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 23.04.2022.
//

import Foundation

/// Facade - provides a simple, easy to understand, user interface over a large and sophisticated body of code

class Buffer {
    var width, height: Int
    var buffer: [Character]
    
    init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
        buffer = [Character](repeating: " ", count: width*height)
    }
    
    subscript(_ index: Int) -> Character {
        return buffer[index]
    }
    
}

class ViewPort {
    var buffer: Buffer
    var offset = 0
    
    init(_ buffer: Buffer) {
        self.buffer = buffer
    }
    
    func getCharacterAt(_ index: Int) -> Character {
        return buffer[offset + index]
    }
    
}

class Console {
    var buffers = [Buffer]()
    var viewPorts = [ViewPort]()
    
    init() {
        let b = Buffer(30, 20)
        let v = ViewPort(b)
        buffers.append(b)
        viewPorts.append(v)
    }
    
    func getCharacterAt(_ index: Int) -> Character {
        return viewPorts[0].getCharacterAt(index)
    }
}


func facade() {
   let c = Console()
    let u = c.getCharacterAt(1)
}
