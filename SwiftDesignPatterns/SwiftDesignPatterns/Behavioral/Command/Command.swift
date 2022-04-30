//
//  Command.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 30.04.2022.
//

import Foundation

class BankAccount: CustomStringConvertible {
    
    private var balance = 0
    private let overdraftLimit = -500
    
    func deposit(_ amount: Int) {
        balance += amount
        print("Deposited \(amount), balance now is \(balance)")
    }
    
    func withdraw(_ amount: Int) -> Bool {
        if (balance - amount >= overdraftLimit) {
            balance -= amount
            print("Withdrew \(amount), balance now is \(balance)")
            return true
        } else {
            return false
        }
    }
    
    var description: String {
        return "Balance is \(balance)"
    }
}

protocol Command {
    func call()
    func undo()
}

class BankAccountCommand: Command {
    
    private var account: BankAccount
    
    enum Action {
        case deposit, withdraw
    }
    
    private var action: Action
    private var amount: Int
    private var succceded: Bool = false
    
    init(_ account: BankAccount, _ action: Action, _ amount: Int) {
        self.account = account
        self.action = action
        self.amount = amount
    }
    
    func call() {
        switch action {
        case .deposit:
            account.deposit(amount)
            succceded = true
        case .withdraw:
            account.withdraw(amount)
        }
    }
    
    func undo() {
        
        if !succceded { return }
        
        switch action {
        case .deposit:
            account.withdraw(amount)
        case .withdraw:
            account.deposit(amount)
            succceded = true
        }
    }
}

func command() {
    
    let ba = BankAccount()
    let commands = [
        BankAccountCommand(ba, .deposit, 100),
        BankAccountCommand(ba, .withdraw, 25)
    ]
    
    print(ba)
    
    commands.forEach({ $0.call() })
    
    print(ba)
    
    commands.reversed().forEach({$0.undo()})
    print(ba)
    
}
