//
//  AppAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

class AppAssembly {

    lazy var scenesAssembly: ScenesAssembly = {
        return ScenesAssembly(servicesAssembly: servicesAssembly)
    }()

    lazy var coordinatorsAssembly: CoordinatorsAssemblyProtocol = {
        return CoordinatorsAssembly(scenesAssembly: scenesAssembly, servicesAssembly: servicesAssembly)
    }()

    lazy var servicesAssembly: ServicesAssembly = {
        return ServicesAssembly()
    }()
}
