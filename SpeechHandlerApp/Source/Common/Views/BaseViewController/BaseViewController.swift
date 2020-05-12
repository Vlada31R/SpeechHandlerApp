//
//  BaseViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Async

class BaseViewController: UIViewController, StoryboardIdentifiable {

    fileprivate var keyboardManager: IQKeyboardManager {
        return IQKeyboardManager.shared
    }

    // MARK: Life Cycle
    deinit {
        self.disableKeyboardHandling()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.enableKeyboardHandling()
    }
}

// MARK: - Keybord Handling
fileprivate extension BaseViewController {

    func enableKeyboardHandling() {

        keyboardManager.enable = true
        keyboardManager.shouldResignOnTouchOutside = true

        let selfType = type(of: self)
        let isKeyboardManagerEnabled = keyboardManager.enable

        if !isKeyboardManagerEnabled { keyboardManager.enabledTouchResignedClasses.append(selfType) }
    }

    func disableKeyboardHandling() {

        let selfType = type(of: self)

        if let index = keyboardManager.disabledTouchResignedClasses.index(where: { $0 == selfType }) {
            keyboardManager.disabledTouchResignedClasses.remove(at: index)
        }

        if let index = keyboardManager.enabledTouchResignedClasses.index(where: { $0 == selfType }) {
            keyboardManager.enabledTouchResignedClasses.remove(at: index)
        }
    }
}

// MARK: - Alert showing
extension BaseViewController {

    func showAlert(message: String) {

        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Close",
                                         style: .default,
                                         handler: nil)

        alert.addAction(cancelAction)

        Async.main {
            self.present(alert, animated: true)
        }
    }

    func showDiscardChangesAlert(discardAction: @escaping ()-> ()) {

        let alert = UIAlertController(title: nil,
                                      message: "Do you want to discard changes?",
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: nil)

        let discardAction = UIAlertAction(title: "Discard",
                                          style: .destructive,
                                          handler: { action in discardAction() })

        alert.addAction(cancelAction)
        alert.addAction(discardAction)

        Async.main {
            self.present(alert, animated: true)
        }
    }
}
