//
//  LoginCoordinator.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Firebase

class LoginCoordinator {

    fileprivate let window: UIWindow

    private let scenesAssembly: ScenesAssembly
    private var loginController: LoginViewController?

    init(window: UIWindow,
         scenesAssembly: ScenesAssembly) {

        self.window = window
        self.scenesAssembly = scenesAssembly
    }
}

// MARK: - Coordinator
extension LoginCoordinator: Coordinator {

    func start() {

        loginController = scenesAssembly.scenesLoginFlowAssembly.instantiateLoginVC(delegate: self)

        guard let loginVC = loginController else { return }

        window.rootViewController = UINavigationController(rootViewController: loginVC)
    }
}

// MARK: - LoginViewControllerDelegate
extension LoginCoordinator: LoginViewControllerDelegate {

    func loginViewControllerDidTapSignUp(_ viewController: LoginViewController) {

        let signUpVC = scenesAssembly.scenesLoginFlowAssembly.instantiateSignUpVC(delegate: self)
        loginController?.navigationController?.pushViewController(signUpVC, animated: true)
    }

    func loginViewControllerDidTapSignIn(_ viewController: LoginViewController) {

        let signInVC = scenesAssembly.scenesLoginFlowAssembly.instantiateSignInVC(delegate: self)
        loginController?.navigationController?.pushViewController(signInVC, animated: true)
    }
}

// MARK: - SignUpViewControllerDelegate
extension LoginCoordinator: SignUpViewControllerDelegate {

    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController, with user: User) {

    }
}

// MARK: - SignInViewControllerDelegate
extension LoginCoordinator: SignInViewControllerDelegate {

    func signInViewControllerDidSignIn(_ viewController: SignInViewController, with user: User) {

    }
}
