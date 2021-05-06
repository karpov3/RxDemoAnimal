//
//  FactoryMock.swift
//  RxDemoTests
//
//  Created by Alexander Karpov on 05/05/21.
//

import Foundation
import RxDemo
import Moya
import UIKit
import RxSwift
import RxTest

public class FactoryMock: FactoryType {
    
    public func animalManager() -> AnimalManagerType {
        AnimalManager(animalClient: animalClient())
    }
    
    public func animalListViewModel(scheduler: SchedulerType) -> AnimalListViewModelling {
        AnimalListViewModel(manager: animalManager(), searchKeyScheduler: scheduler)
    }
    
    public func animalClient() -> AnimalClientType {
        
        let provider = MoyaProvider<AnimalService>(endpointClosure: { service -> Endpoint in
            
            var assetName: String = ""
            
            switch service.serviceRequest {
            case .cat:
                assetName = "cats"
            case .dog:
                assetName = "dogs"
            }

            return Endpoint(url: service.baseURL.absoluteString,
                            sampleResponseClosure: { () -> EndpointSampleResponse in
                                
                                let data = NSDataAsset(name: assetName, bundle: Bundle.main)?.data ?? Data()
                                return EndpointSampleResponse.networkResponse(200, data)
                                
                            },
                            method: service.method,
                            task: service.task,
                            httpHeaderFields: service.headers)
        }, stubClosure: MoyaProvider.immediatelyStub)
        
        
        return AnimalClient(baseUrl: URL(string: "https://animal.example")!, provider: provider)
    }
    
    
    
}


public class AnimalManagerMock: AnimalManagerType {
    
    // MARK: AnimalManagerType
    public func animals() -> Observable<[Animal]> {
//        return Observable.error(AnimalError.badResponse)
        return Observable.just(animal)
    }
        
    // MARK: Initialisation

    let animal: [Animal]
  
    internal init(animal: [Animal]) {
        self.animal = animal
    }
    
    init() {
        self.animal = []
    }
    
}
