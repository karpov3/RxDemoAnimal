//
//  AnimalListViewModelling.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import RxCocoa

public protocol AnimalListViewModelling {
    
    var count: Driver<Int> { get }
    
    var data: Driver<[Animal]> { get }
    
    var errorMessage: Driver<String> { get }
    
    var searchKey: PublishRelay<String> { get }
    
}
