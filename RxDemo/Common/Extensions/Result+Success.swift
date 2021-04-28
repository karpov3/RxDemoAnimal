//
//  Result+Success.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation

extension Result {
    public var success: Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
}
