//
//  RxDemoTests.swift
//  RxDemoTests
//
//  Created by Alexander Karpov on 26/04/21.
//

import XCTest
import RxSwift
import RxTest

@testable import RxDemo

class RxDemoUnitTests: XCTestCase {
    
    var dispose: DisposeBag!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        dispose = DisposeBag()
    }
    
    func testSimpleExample() throws {
        let viewModel = AnimalListViewModel(manager: AnimalManagerMock())
        
        let result = viewModel.pureFunction(value: 2)
        
        XCTAssertEqual(result, 4)
    }
    
    func testResult() throws {
        
        let cats: [Animal] = try! Fixture.get(.cats)
        let viewModel = AnimalListViewModel(manager: AnimalManagerMock(animal: cats))
        
        let expectation = XCTestExpectation(description: "Test Animal ViewModel Result")
        
        viewModel.result
            .subscribe(onNext: { response in
                
                let result: Result<[Animal], AnimalError> = response
                
                switch result {
                case .success(let animal):
                    XCTAssertEqual(animal.count, 38)
                    expectation.fulfill()
                    
                case .failure:
                    XCTFail("Should emit only success result")
                    expectation.fulfill()
                }
                
            
        }, onError: { animal in
            XCTFail("Impossible case. Result property should never emit an error.")
            expectation.fulfill()
        })
        .disposed(by: dispose)
        
        viewModel.searchKey.accept("a")
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testResultRxTest() throws {
        scheduler = TestScheduler(initialClock: 0)

        let cats: [Animal] = try! Fixture.get(.cats)
        let viewModel = AnimalListViewModel(manager: AnimalManagerMock(animal: cats), searchKeyScheduler: scheduler)
                
        let observer = scheduler.createObserver(Int.self)
        
        _ = viewModel.result
            .map{$0.success?.count ?? 0}
            .asObservable()
            .bind(to:observer)
            .disposed(by: dispose)
        
        
        let buttonTaps = scheduler.createColdObservable([Recorded.next(0, "a"), Recorded.next(0, "ab"), Recorded.next(0, "a"), Recorded.next(2, ""), Recorded.next(4, "ab")])
        buttonTaps.bind(to: viewModel.searchKey).disposed(by: dispose)
                    
        scheduler.start()
        
        
        
          let results = observer.events.compactMap {
            $0.value
          }

        XCTAssertEqual(results, [Event.next(38), Event.next(0), Event.next(2)])
    }
  

}
