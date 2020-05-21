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
    func instantiateRecordingVC(delegate: RecordingViewControllerDelegate) -> RecordingViewController
    func instantiateSaveAudioVC(filePath: URL,
                                delegate: SaveAudioViewControllerDelegate) -> SaveAudioViewController
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
        controller.delegate = delegate
        return controller
    }

    func instantiateRecordingVC(delegate: RecordingViewControllerDelegate) -> RecordingViewController {

        let controller: RecordingViewController = UIStoryboard.mainFlowStoryboard.instantiateViewController()
        controller.delegate = delegate
        return controller
    }

    func instantiateSaveAudioVC(filePath: URL,
                                delegate: SaveAudioViewControllerDelegate) -> SaveAudioViewController {

        let controller: SaveAudioViewController = UIStoryboard.mainFlowStoryboard.instantiateViewController()
        controller.filePath = filePath
        controller.networkManager = servicesAssembly.networkManager
        controller.firebaseService = servicesAssembly.firebaseService
        controller.delegate = delegate
        return controller
    }
}
