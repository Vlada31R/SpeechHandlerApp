//
//  CoordinatorsAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol CoordinatorsAssemblyProtocol {

    func makeAppCoordinator(window: UIWindow) -> Coordinator
}

class CoordinatorsAssembly {

    private var scenesAssembly: ScenesAssembly
    private var servicesAssembly: ServicesAssembly

    init(scenesAssembly: ScenesAssembly, servicesAssembly: ServicesAssembly) {

        self.scenesAssembly = scenesAssembly
        self.servicesAssembly = servicesAssembly
    }
}

// MARK: - CoordinatorsAssemblyProtocol
extension CoordinatorsAssembly: CoordinatorsAssemblyProtocol {

    func makeAppCoordinator(window: UIWindow) -> Coordinator {

        return ApplicationCoordinator(window: window,
                                      scenesAssembly: scenesAssembly,
                                      coordAssembly: self)
    }
}
