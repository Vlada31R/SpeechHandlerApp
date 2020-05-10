//
//  SignInViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: class {

    func signInViewControllerDidTapSignIn(_ viewController: SignInViewController)
}

class SignInViewController: UIViewController, StoryboardIdentifiable {

    weak var delegate: SignInViewControllerDelegate?

    @IBAction func didTapSignInButton(_ sender: UIButton) {

        delegate?.signInViewControllerDidTapSignIn(self)
    }
}
