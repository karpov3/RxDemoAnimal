//
//  Client.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import RxMoya
import Moya
import RxSwift

public class AnimalClient: AnimalClientType {

    var provider: MoyaProvider<AnimalService>

    let baseUrl: URL

    public init(baseUrl: URL, provider: MoyaProvider<AnimalService> = MoyaProvider<AnimalService>()) {
        self.baseUrl = baseUrl
        self.provider = provider
    }
}

public protocol AnimalClientType {

    func cats() -> Single<[Animal]>

    func dogs() -> Single<[Animal]>

}


extension AnimalClient {
    
    public func cats() -> Single<[Animal]> {
        
        self.provider
            .rx
            .request(AnimalService(serviceRequest: .cat, baseURL: baseUrl))
            .map([Animal].self)
    }
    
    public func dogs() -> Single<[Animal]> {
        
        self.provider
            .rx
            .request(AnimalService(serviceRequest: .dog, baseURL: baseUrl))
            .map([Animal].self)
    }
}
