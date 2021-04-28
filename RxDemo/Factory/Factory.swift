//
//  Factory.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import UIKit
import Moya
public protocol FactoryType {
    
    func animalClient() -> AnimalClientType
    
    func animalManager() -> AnimalManagerType
    
    func animalListViewModel() -> AnimalListViewModelling

}

public class Factory: FactoryType {
    
    
    public func animalManager() -> AnimalManagerType {
        AnimalManager(animalClient: animalClient())
    }
    
    public func animalListViewModel() -> AnimalListViewModelling {
        AnimalListViewModel(manager: animalManager())
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
                                return EndpointSampleResponse.networkResponse(200, data) },
                            method: service.method,
                            task: service.task,
                            httpHeaderFields: service.headers)
        }, stubClosure: MoyaProvider.immediatelyStub)
        
        
        return AnimalClient(baseUrl: URL(string: "https://animal.example")!, provider: provider)
    }
    
    
    
}


