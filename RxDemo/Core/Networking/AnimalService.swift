//
//  Service.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import Moya

public enum AnimalServiceRequest {
    case cat
    case dog
}

public struct AnimalService {

    public let serviceRequest: AnimalServiceRequest

    public let baseURL: URL

    init(serviceRequest: AnimalServiceRequest, baseURL: URL) {
        self.serviceRequest = serviceRequest
        self.baseURL = baseURL
    }
}

extension AnimalService: Moya.TargetType {

    public var path: String {
        
        switch serviceRequest {
        case .cat: return "/cat"
        case .dog: return "/dog"
        }
    }
    public var method: Moya.Method {
        .get
    }

    public var headers: [String: String]? {
        nil
    }

    public var sampleData: Data { Data() }

    public var task: Task { .requestPlain }

    public var validationType: ValidationType { .successCodes }
}

