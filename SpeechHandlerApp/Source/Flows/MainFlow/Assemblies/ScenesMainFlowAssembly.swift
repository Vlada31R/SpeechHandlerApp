//
//  ScenesMainFlowAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Firebase

protocol ScenesMainFlowAssemblyProtocol {

    func instantiateAudioListVC(delegate: AudioListViewControllerDelegate) -> AudioListViewController
}

class ScenesMainFlowAssembly {

    var servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}

// MARK: - ScenesMainFlowAssemblyProtocol
extension ScenesMainFlowAssembly: ScenesMainFlowAssemblyProtocol {

    func instantiateAudioListVC(delegate: AudioListViewControllerDelegate) -> AudioListViewController {

        let controller: AudioListViewController = UIStoryboard.mainFlowStoryboard.instantiateViewController()
        controller.authService = servicesAssembly.authService
        controller.delegate = delegate
        return controller
    }
}
