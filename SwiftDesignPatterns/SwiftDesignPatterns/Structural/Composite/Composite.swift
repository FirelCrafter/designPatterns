//
//  Composite.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 18.04.2022.
//

import Foundation

class GraphicObject : CustomStringConvertible {
    var name: String = "Group"
    var color: String = ""

    var children = [GraphicObject]()

    init() { }

    init(name: String) {
        self.name = name
    }

    private func print(buffer: inout String, depth: Int) {
        buffer.append(String(repeating: "*", count: depth))
        buffer.append(color.isEmpty ? "" : "\(color) ")
        buffer.append("\(name)\n")

        for child in children {
            child.print(buffer: &buffer, depth: depth+1)
        }
    }

    var description: String {
        var buffer = ""
        print(buffer: &buffer, depth: 0)
        return buffer
    }
}

class CompositeCircle : GraphicObject {
    init(color: String) {
        super.init(name: "Circle")
        self.color = color
    }
}

class CompositeSquare : GraphicObject {
    init(color: String) {
        super.init(name: "Square")
        self.color = color
    }
}

func composite() {
    let drawing = GraphicObject(name: "My Drawing")
    drawing.children.append(CompositeSquare(color: "Red"))
    drawing.children.append(CompositeCircle(color: "Yellow"))

    let group = GraphicObject()
    group.children.append(CompositeCircle(color: "Blue"))
    group.children.append(CompositeSquare(color: "Blue"))

    drawing.children.append(group)

    print(drawing.description)
}

