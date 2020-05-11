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
    private var mainCoordinator: Coordinator?

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

        let loginCoordCompletion = { [weak self] in

            guard let strongSelf = self else { return }

            strongSelf.mainCoordinator = strongSelf.coordAssembly.makeMainCoordinator(window: strongSelf.window)
            strongSelf.mainCoordinator?.start()
            strongSelf.loginCoordinator = nil
        }

        loginCoordinator = coordAssembly.makeLoginCoordinator(window: window,
                                                              completion: loginCoordCompletion)
        loginCoordinator?.start()
    }
}

