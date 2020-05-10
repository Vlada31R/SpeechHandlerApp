//
//  SignUpViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Firebase

protocol SignUpViewControllerDelegate: class {

    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController, with user: User)
}

class SignUpViewController: BaseViewController, StoryboardIdentifiable {

    weak var delegate: SignUpViewControllerDelegate?

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!

    @IBAction func didTapSignUpButton(_ sender: UIButton) {

        guard let email = emailTextField.text,
              email.isEmail,
              let password = passwordTextField.text,
              let repeatPassword = repeatPasswordTextField.text,
              password.count >= 6,
              password == repeatPassword
        else {
            self.showAlert(message: "Entered data not valid.")
            return
        }

        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { [weak self] authResult, error in

                                   guard let strongSelf = self else { return }

                                   guard error == nil,
                                         let user = authResult?.user
                                   else {
                                       strongSelf.showAlert(message: "Something went wrong. Please try again later.")
                                       return
                                   }

                                   strongSelf.delegate?.signUpViewControllerDidSignUp(strongSelf, with: user)
        })
    }
}
