//
//  Fixture.swift
//  RxDemoTests
//
//  Created by Alexander Karpov on 05/05/21.
//

import Foundation
import UIKit
public class Fixture {
    
    public enum FixtureType {
        case cats
        case dogs

        public var fileName: String {
            switch self {
            case .cats: return "cats"
            case .dogs: return "dogs"
            }
        }
    }
    
    public static func get<T: Decodable>(_ fixtureType: FixtureType, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        
        let data = NSDataAsset(name: fixtureType.fileName, bundle: Bundle.main)!.data
        return try decoder.decode(T.self, from: data)
    }
    
    public static func getData(_ fixtureType: FixtureType) throws -> Data {
        return NSDataAsset(name: fixtureType.fileName, bundle: Bundle.main)!.data
    }

}
