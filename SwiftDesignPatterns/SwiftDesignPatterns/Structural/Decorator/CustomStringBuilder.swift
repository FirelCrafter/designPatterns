//
//  CustomStringBuilder.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 22.04.2022.
//

import Foundation

/// Decorator - facilitates the addition of behaviors to individual objects without inhariting from them

class CodeBuilder: CustomStringConvertible {
    
    private var buffer: String = ""
    
    init() { }
    
    init(_ buffer: String) {
        self.buffer = buffer
    }
    
    func append(_ s: String) -> CodeBuilder {
        buffer.append(s)
        return self
    }
    
    func appendline(_ s: String) -> CodeBuilder {
        buffer.append("\(s)\n")
        return self
    }
    
    static func +=(cb: inout CodeBuilder, s: String) {
        cb.buffer.append(s)
    }
    
    var description: String {
        return buffer
    }
}

func customStringBuilder() {
    var cb = CodeBuilder()
    cb.append("foo").append("bar")
    
    
}
