//
//  ScenesLoginFlowAssembly.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol ScenesLoginFlowAssemblyProtocol {

    func instantiateLoginVC(delegate: LoginViewControllerDelegate) -> LoginViewController
    func instantiateSignUpVC(delegate: SignUpViewControllerDelegate) -> SignUpViewController
    func instantiateSignInVC(delegate: SignInViewControllerDelegate) -> SignInViewController
}

class ScenesLoginFlowAssembly {

    var servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}

// MARK: - ScenesLoginFlowAssemblyProtocol
extension ScenesLoginFlowAssembly: ScenesLoginFlowAssemblyProtocol {

    func instantiateLoginVC(delegate: LoginViewControllerDelegate) -> LoginViewController {

        let controller: LoginViewController = UIStoryboard.loginFlowStoryboard.instantiateViewController()
        controller.delegate = delegate
        return controller
    }

    func instantiateSignUpVC(delegate: SignUpViewControllerDelegate) -> SignUpViewController {

        let controller: SignUpViewController = UIStoryboard.loginFlowStoryboard.instantiateViewController()
        controller.delegate = delegate
        return controller
    }

    func instantiateSignInVC(delegate: SignInViewControllerDelegate) -> SignInViewController {

        let controller: SignInViewController = UIStoryboard.loginFlowStoryboard.instantiateViewController()
        controller.delegate = delegate
        return controller
    }
}
