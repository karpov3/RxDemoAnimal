//
//  ParentChildCoordinatorType.swift
//  RxDemo
//
//  Created by Alexander Karpov on 26/04/21.
//

import Foundation
public protocol ParentChildCoordinatorType: class {
    
    var childCoordinators: [ParentChildCoordinatorType] { get set }

    var parentCoordinator: ParentChildCoordinatorType? { get set }
}

public extension ParentChildCoordinatorType {

    func add(childCoordinator: ParentChildCoordinatorType) {
        childCoordinators.append(childCoordinator)
        childCoordinator.parentCoordinator = self
    }

    func remove(childCoordinator: ParentChildCoordinatorType) {
        if let index = childCoordinators.index(where: { $0 === childCoordinator }) {
            childCoordinators.remove(at: index)
            childCoordinator.parentCoordinator = nil
        }
    }

    func removeFromParentCoordinator() {
        parentCoordinator?.remove(childCoordinator: self)
    }
}
