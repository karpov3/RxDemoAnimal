//
//  Observable+wrapInResult.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import RxSwift

extension Observable {
    public func wrapInResult() -> Observable<Result<Element, AnimalError>> {
        self.map { element -> Result<Element, AnimalError> in
            .success(element)
        }
        .catchError { error -> Observable<Result<Element, AnimalError>> in
            guard let err = error as? AnimalError else {
                return Observable<Result<Element, AnimalError>>.just(.failure(AnimalError.undefined))
            }
            
            return Observable<Result<Element, AnimalError>>.just(.failure(err))
        }
    }
}
