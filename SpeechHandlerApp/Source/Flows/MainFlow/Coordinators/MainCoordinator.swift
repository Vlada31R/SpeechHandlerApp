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
extension MainCoordinator: AudioListViewControllerDelegate {

    func audioListViewControllerDidCreateNewTrack(_ viewController: AudioListViewController) {

        let recordingVC = scenesAssembly.scenesMainFlowAssembly.instantiateRecordingVC(delegate: self)
        viewController.navigationController?.pushViewController(recordingVC, animated: true)
    }
}

// MARK: - RecordingViewControllerDelegate
extension MainCoordinator: RecordingViewControllerDelegate {
    
    func recordingViewController(_ viewController: RecordingViewController, recordAudioAt path: URL) {

        let saveAudioVC = scenesAssembly.scenesMainFlowAssembly.instantiateSaveAudioVC(filePath: path,
                                                                                       delegate: self)
        viewController.navigationController?.pushViewController(saveAudioVC, animated: true)
    }
}

// MARK: - SaveAudioViewControllerDelegate
extension MainCoordinator: SaveAudioViewControllerDelegate {

    func saveAudioViewControllerDidCancel(_ viewController: SaveAudioViewController) {

        guard let listVC = audioListController else { return }

        viewController.navigationController?.popToViewController(listVC, animated: true)
    }

    func saveAudioViewController(_ viewController: SaveAudioViewController, didSave model: TrackModel) {

        guard let listVC = audioListController else { return }

        viewController.navigationController?.popToViewController(listVC, animated: true)

        listVC.trackModels.append(model)
    }
}
