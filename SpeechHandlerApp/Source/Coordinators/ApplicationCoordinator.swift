//
//  ApplicationCoordinator.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

class ApplicationCoordinator {

    let window: UIWindow

    private var scenesAssembly: ScenesAssembly
    private var coordAssembly: CoordinatorsAssemblyProtocol

    private var childCoordinators: [Coordinator] = []

    init(window: UIWindow,
         scenesAssembly: ScenesAssembly,
         coordAssembly: CoordinatorsAssemblyProtocol) {

        self.window = window
        self.scenesAssembly = scenesAssembly
        self.coordAssembly = coordAssembly
    }
}

// MARK: - Coordinator
extension ApplicationCoordinator: Coordinator {

    func start() {}
}

