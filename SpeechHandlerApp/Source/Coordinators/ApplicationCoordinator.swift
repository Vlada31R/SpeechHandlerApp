//
//  ApplicationCoordinator.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

class ApplicationCoordinator {

    fileprivate let window: UIWindow

    private var scenesAssembly: ScenesAssembly
    private var coordAssembly: CoordinatorsAssemblyProtocol

    private var loginCoordinator: Coordinator?

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

    func start() {

        window.makeKeyAndVisible()

        loginCoordinator = coordAssembly.makeLoginCoordinator(window: window)
        loginCoordinator?.start()
    }
}

