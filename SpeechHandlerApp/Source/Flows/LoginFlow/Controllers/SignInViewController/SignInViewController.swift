//
//  SignInViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Firebase

protocol SignInViewControllerDelegate: class {

    func signInViewControllerDidSignIn(_ viewController: SignInViewController, with user: User)
}

class SignInViewController: BaseViewController, StoryboardIdentifiable {

    weak var delegate: SignInViewControllerDelegate?

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    @IBAction func didTapSignInButton(_ sender: UIButton) {

        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { [weak self] authResult, error in

                               guard let strongSelf = self else { return }

                               guard error == nil,
                                     let user = authResult?.user
                               else {
                                   return
                               }

                               strongSelf.delegate?.signInViewControllerDidSignIn(strongSelf, with: user)
        })
    }
}
