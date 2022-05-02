//
//  LexingInterpreter.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 02.05.2022.
//

import Foundation


struct Token: CustomStringConvertible {
    
    enum TokenType{
        case integer, plus, minus, lparen, rparen
    }
    
    var tokenType: TokenType
    var text: String
    
    init(_ tokenType: TokenType, _ text: String) {
        self.tokenType = tokenType
        self.text = text
    }
    
    var description: String {
        return "`\(text)`"
    }
}

func lex(_ input: String) -> [Token] {
    var result = [Token]()
    var i = 0
    while i < input.count {
        switch input[i] {
        case "+":
            result.append(Token(.plus, "+"))
        case "-":
            result.append(Token(.minus, "-"))
        case "(":
            result.append(Token(.lparen, "("))
        case ")":
            result.append(Token(.rparen, ")"))
        default:
            var s = String(input[i])
            for j in (i+1)..<input.count {
                if String(input[j]).isNumber {
                    s.append(input[j])
                    i+=1
                } else {
                    result.append(Token(.integer, s))
                    break
                }
            }
        }
        i+=1
    }
    return result
}

protocol Element {
    var value: Int { get }
}

class Integer: Element {
    var value: Int
    
    init(_ value: Int) {
        self.value = value
    }
}

class BinaryOpertion: Element {
    
    enum OpType {
        case addition, substraction
    }
    
    var opType = OpType.addition
    var left = Integer(0)
    var right = Integer(0)
    
    init() {  }
    
    init(_ left: Element, _ right: Element, _ opType: Element) {
        self.opType = opType
        self.left = left
        self.right = right
    }
    
    var value: Int {
        switch opType {
        case .addition:
            return left.value + right.value
        case .substraction:
            return left.value - right.value
        }
    }
}

func parse(_ tokens: [Token]) -> Element {
    let result = BinaryOpertion()
    var haveLHS = false
    
    var i = 0
    while i < tokens.count {
        let token = tokens[i]
        switch token.tokenType {
        case .integer:
            let integer = Integer(Int(token.text)!)
            if !haveLHS {
                result.left = integer
                haveLHS = true
            } else {
                result.right = integer
            }
        case .plus:
            result.opType = .addition
        case .minus:
            result.opType = .substraction
        case .lparen:
            <#code#>
        case .rparen:
            <#code#>
        }
    }
}

func lexingInterpreter() {
    let input = "(13+4)-(12-1)"
    let tokens = lex(input)
    print(tokens)
    let parsed = parse(tokens)
    print("\(input) = \(parsed.value)")
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    var isNumber: Bool {
        get {
            return !self.isEmpty && (self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil)
        }
    }
}
