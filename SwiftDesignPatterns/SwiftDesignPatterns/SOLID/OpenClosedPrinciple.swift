//
//  OpenClosedPrinciple.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 16.04.2022.
//

import Foundation

enum Color
{
  case red
  case green
  case blue
}

enum Size
{
  case small
  case medium
  case large
  case yuge
}

class Product
{
  var name: String
  var color: Color
  var size: Size

  init(_ name: String, _ color: Color, _ size: Size)
  {
    self.name = name
    self.color = color
    self.size = size
  }
}

class ProdunctFilter {
    
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        var result = [Product]()
        for p in products {
            if p.color == color {
                result.append(p)
            }
        }
        return result
    }
    
    // Нарушение OCP
    /*
     func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
         var result = [Product]()
         for p in products {
             if p.size == size {
                 result.append(p)
             }
         }
         return result
     }
     */
    
    
}

protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
    where Spec.T == T;
}

class ColorSpecification: Specification {
    
    typealias T = Product
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    
    typealias T = Product
    let size: Size
    
    init(_ size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T,
                    SpecA: Specification,
                    SpecB: Specification>: Specification
                    where SpecA.T == SpecB.T,
                    T == SpecA.T {
    let first: SpecA
    let second: SpecB
    
    init(_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    
    typealias T = Product
    
    func filter<Spec>(_ items: [Product], _ spec: Spec) -> [Product] where Spec : Specification, Product == Spec.T {
        var result = [Product]()
        for i in items {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        return result
    }
}


func ocp() {
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("House", .blue, .large)
    
    let products = [apple, tree, house]
    
    let pf = ProdunctFilter()
    print("Green products (old): ")
    for p in pf.filterByColor(products, .green) {
        print(" - \(p.name) is green")
    }
    
    let bf = BetterFilter()
    print("Green products (new): ")
    for p in bf.filter(products, ColorSpecification(.green)) {
        print(" - \(p.name) is green")
    }
    
    print("Large blue items")
    for p in bf.filter(products, AndSpecification(
        ColorSpecification(.blue),
        SizeSpecification(.large))) {
        print(" - \(p.name) is blue and large")
    }
}
