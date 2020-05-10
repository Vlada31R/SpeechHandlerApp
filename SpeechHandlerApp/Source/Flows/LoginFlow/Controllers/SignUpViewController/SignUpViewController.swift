//
//  SignUpViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate: class {

    func signUpViewControllerDidTapSignUp(_ viewController: SignUpViewController)
}

class SignUpViewController: UIViewController, StoryboardIdentifiable {

    weak var delegate: SignUpViewControllerDelegate?
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {

        delegate?.signUpViewControllerDidTapSignUp(self)
    }
}
