//
//  ScenesAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

class ScenesAssembly {

    private var servicesAssembly: ServicesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }

    lazy var scenesLoginFlowAssembly: ScenesLoginFlowAssemblyProtocol = {
        return ScenesLoginFlowAssembly(servicesAssembly: servicesAssembly)
    }()

    lazy var scenesMainFlowAssembly: ScenesMainFlowAssemblyProtocol = {
        return ScenesMainFlowAssembly(servicesAssembly: servicesAssembly)
    }()
}
