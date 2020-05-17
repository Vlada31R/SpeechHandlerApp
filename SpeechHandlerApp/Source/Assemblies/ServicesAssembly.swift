//
//  ServicesAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

class ServicesAssembly {

    lazy var authService: AuthService = {
        return AuthService()
    }()

    lazy var networkManager: NetworkManager = {
        return NetworkManagerImp()
    }()
}
