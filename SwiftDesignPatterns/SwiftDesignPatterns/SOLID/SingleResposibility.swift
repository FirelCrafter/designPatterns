//
//  SingleResposibility.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 16.04.2022.
//

import Foundation

class Journal: CustomStringConvertible {
    
    var entries = [String]()
    var count = 0
    
    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }
    
    var description: String {
        return entries.joined(separator: "\n")
    }
    
    // Нарушение принципа SRP
    /*
     func save(_ filename: String, _ overwrite: Bool = false) {
         // save to file
     }
     
     func load(_ filename: String) {}
     func load(_ url: URL) {}
     */
    
}

class Persistence {
    
    func saveToFile(_ journal: Journal,
                    _ filename: String,
                    _ overwrite: Bool = false) {
        // save to file
    }
    
}



func srp() {
    let j = Journal()
    let _ = j.addEntry("I cried today")
    let bug = j.addEntry("I ate a bug")
    print(j)
    
    j.removeEntry(bug)
    print("===")
    print(j)
    
    let p = Persistence()
    let filename = "user/file.txt"
    p.saveToFile(j, filename)
}
