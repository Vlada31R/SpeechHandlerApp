//
//  LoginCoordinator.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

class LoginCoordinator {

    private let scenesAssembly: ScenesAssembly
    private var controller: LoginViewController?

    init(scenesAssembly: ScenesAssembly) {

        self.scenesAssembly = scenesAssembly
    }
}

// MARK: - Coordinator
extension LoginCoordinator: Coordinator {

    func start() {

        controller = scenesAssembly.scenesLoginFlowAssembly.instantiateLoginVC(delegate: self)
    }
}

// MARK: - LoginViewControllerDelegate
extension LoginCoordinator: LoginViewControllerDelegate {

    func loginViewControllerDidTapSignUp(_ viewController: LoginViewController) {

        let signUpVC = scenesAssembly.scenesLoginFlowAssembly.instantiateSignUpVC(delegate: self)
    }

    func loginViewControllerDidTapSignIn(_ viewController: LoginViewController) {

        let signInVC = scenesAssembly.scenesLoginFlowAssembly.instantiateSignInVC(delegate: self)
    }
}

// MARK: - SignUpViewControllerDelegate
extension LoginCoordinator: SignUpViewControllerDelegate {

    func signUpViewControllerDidTapSignUp(_ viewController: SignUpViewController) {

    }
}

// MARK: - SignInViewControllerDelegate
extension LoginCoordinator: SignInViewControllerDelegate {

    func signInViewControllerDidTapSignIn(_ viewController: SignInViewController) {

    }
}
