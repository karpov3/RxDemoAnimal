//
//  AnimalManager.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import RxSwift

public protocol AnimalManagerType {
    
    func animals() -> Observable<[Animal]>
}


public class AnimalManager: AnimalManagerType {
    
    // MARK: AnimalManagerType
    
    public func animals() -> Observable<[Animal]> {
        
        let catsEvent = animalClient.cats().asObservable()
        let dogsEvent = animalClient.dogs().asObservable()
        
        return Observable
            .combineLatest(catsEvent, dogsEvent){ (cats, dogs) -> [Animal] in
                cats + dogs
            }
            .share(replay: 1, scope: .whileConnected)
    }
    
    
    // MARK: Initialisation
    
    let animalClient: AnimalClientType
    
    public init(animalClient: AnimalClientType) {
        self.animalClient = animalClient
    }
}
