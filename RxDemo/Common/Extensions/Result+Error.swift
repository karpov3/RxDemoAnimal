//
//  Result+Error.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation

extension Result {
    public var error: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
