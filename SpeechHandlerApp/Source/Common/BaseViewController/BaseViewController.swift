//
//  BaseViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {

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
