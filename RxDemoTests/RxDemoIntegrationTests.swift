//
//  RxDemoTests.swift
//  RxDemoTests
//
//  Created by Alexander Karpov on 26/04/21.
//

import XCTest
import RxSwift

@testable import RxDemo

class RxDemoIntegrationTests: XCTestCase {

    var dispose: DisposeBag!
    
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
        
        let factory = FactoryMock()
        
        let viewModel = factory.animalListViewModel(scheduler: MainScheduler.instance) as! AnimalListViewModel
        
        let expectation = XCTestExpectation(description: "Test Animal ViewModel Result")
        
        viewModel.result
            .subscribe(onNext: { result in
                
                switch result {
                case .success(let animal):
                    XCTAssertEqual(animal.count, 119)
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
    


}
