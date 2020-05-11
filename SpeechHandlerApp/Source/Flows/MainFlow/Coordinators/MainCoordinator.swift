//
//  MainCoordinator.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Foundation

class MainCoordinator {

    fileprivate let window: UIWindow

    private let scenesAssembly: ScenesAssembly
    private var audioListController: AudioListViewController?

    init(window: UIWindow,
         scenesAssembly: ScenesAssembly) {

        self.window = window
        self.scenesAssembly = scenesAssembly
    }
}

// MARK: - Coordinator
extension MainCoordinator: Coordinator {

    func start() {

        audioListController = scenesAssembly.scenesMainFlowAssembly.instantiateAudioListVC(delegate: self)

        guard let audioListVC = audioListController else { return }

        window.rootViewController = UINavigationController(rootViewController: audioListVC)
    }
}

// MARK: - AudioListViewControllerDelegate
extension MainCoordinator: AudioListViewControllerDelegate {}
