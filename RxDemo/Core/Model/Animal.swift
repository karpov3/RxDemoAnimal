//
//  Animal.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation

public enum AnimalType: String {
    case cat, dog
}

public struct Animal {
    
    let name: String
    
    let animal: AnimalType
    
}


// MARK: Codable

extension Animal: Codable {}

extension AnimalType: Codable {}


