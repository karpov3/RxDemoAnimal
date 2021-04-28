//
//  AnimalListViewModel.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxRelay


public class AnimalListViewModel: AnimalListViewModelling {
    
    var someSideEffect: Int = 10
    
    // MARK: AnimalListViewModelling
    
    public let searchKey = PublishRelay<String>()
    
    public lazy var count: Driver<Int> = result
        .compactMap{$0.success}
        .asDriver(onErrorJustReturn: [])
        .map{$0.count}
        .startWith(0)
    
    
    func makeCount(value: Int) -> Int {
        
        
        return value + self.someSideEffect
    }
    
    func pureFunction(value: Int) -> Int {
        return value * 2
    }
    
    public lazy var errorMessage: Driver<String> = result
        .compactMap{$0.error?.message}
        .asDriver(onErrorJustReturn: "")
    
    public lazy var data: Driver<[Animal]> = result
        .compactMap{$0.success}
        .map{$0.sorted(by: {$0.name < $1.name})}
        .asDriver(onErrorJustReturn: [])
    
    // MARK: Data
    
    lazy var result: Observable<Result<[Animal], AnimalError>> = searchKey
        .debounce(.milliseconds(500), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
        .withUnretained(self)
        .flatMap { (`self`, searchKey) in
            self.manager
                .animals()
                .map{$0.filter{$0.name.lowercased().contains(searchKey.lowercased())}}
                .wrapInResult()
        }
        .share(replay: 1, scope: .whileConnected)
    
    // MARK: Initializaton
    
    let manager: AnimalManagerType
    
    public init(manager: AnimalManagerType) {
        
        self.manager = manager
        
    }
}
