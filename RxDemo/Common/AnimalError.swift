//
//  AnimalError.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation

public enum AnimalError: Error {
    case badResponse, missing, undefined
}


extension AnimalError {
    static func map(_ error: Error) -> AnimalError {
        return .undefined
    }
}


extension AnimalError {
    public var message: String {
        switch self {
        case .badResponse:
            return "Il servizio non risponde. Si prega di riprovare più tardi"
        case .missing:
            return "Non ci sono i dati."
        case .undefined:
            return "Qualcosa è stato implementato male"
        }
    }
}
