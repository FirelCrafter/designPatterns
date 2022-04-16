//
//  FacetedBuilder.swift
//  SwiftDesignPatterns
//
//  Created by Михаил Щербаков on 16.04.2022.
//

import Foundation


class PersonForBuilder: CustomStringConvertible {
    
    var streetAddress = "", postCode = "", city = ""
    var companyName = "", position = ""
    var annualIncome = 0
    
    var description: String {
        return "I live at \(streetAddress), \(postCode), \(city). " +
        "I work at \(companyName) as a \(position), earning \(annualIncome)."
    }
}

class PersonBuilder {
    var person = PersonForBuilder()
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    var works: PersonJobBuilder {
        return PersonJobBuilder(person)
    }
    func build() -> PersonForBuilder {
        return person
    }
}

class PersonAddressBuilder: PersonBuilder {
    internal init(_ person: PersonForBuilder) {
        super.init()
        self.person = person
    }
    
    func at(_ streetAddress: String) -> PersonAddressBuilder {
        person.streetAddress = streetAddress
        return self
    }
    
    func withPostalCode(_ postalCode: String) -> PersonAddressBuilder {
        person.postCode = postalCode
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

class PersonJobBuilder: PersonBuilder {
    internal init(_ person: PersonForBuilder) {
        super.init()
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }
    
    func asA(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }
    
    func earning(_ annualIncome: Int) -> PersonJobBuilder {
        person.annualIncome = annualIncome
        return self
    }
}

func facetedBuilder() {
    let pb = PersonBuilder()
    let p = pb
        .lives.at("123 London Road")
              .inCity("London")
              .withPostalCode("124000")
        .works.at("Fabric")
              .asA("Engeneer")
              .earning(123000)
        .build()
    
    print(p)
}
