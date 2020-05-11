//
//  LoginViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {

    func loginViewControllerDidTapSignUp(_ viewController: LoginViewController)
    func loginViewControllerDidTapSignIn(_ viewController: LoginViewController)
}

class LoginViewController: BaseViewController {

    weak var delegate: LoginViewControllerDelegate?

    @IBAction func didTapSignUpButton(_ sender: UIButton) {

        delegate?.loginViewControllerDidTapSignUp(self)
    }

    @IBAction func didTapSighInButton(_ sender: UIButton) {

        delegate?.loginViewControllerDidTapSignIn(self)
    }
}
