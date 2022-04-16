//
//  InterfaceSegregation.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 16.04.2022.
//

import Foundation


class Document {
    
    
    
}

// Нарушение ISP
/*
protocol Machine {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
}
 */

protocol Printer {
    func print(_ d: Document)
}

protocol Scanner {
    func scan(_ d: Document)
}

protocol Fax {
    func fax(_ d: Document)
}

class ordinaryPrinter: Printer {
    func print(_ d: Document) {
        //print
    }
}

class Photocopier: Scanner, Printer {
    func scan(_ d: Document) {
        // scan
    }
    
    func print(_ d: Document) {
        // print
    }
}

protocol MultiFunctionDevice: Printer, Scanner, Fax { }

class MFP: MultiFunctionDevice {
    
    let printer: Printer
    let scanner: Scanner
    let doc = Document()
    
    init(printer: Printer, scanner: Scanner) {
        self.printer = printer
        self.scanner = scanner
    }
    
    func print(_ d: Document) {
        printer.print(doc) // Decorator
    }
    
    func scan(_ d: Document) {
        //scan
    }
    
    func fax(_ d: Document) {
        //fax
    }
}
