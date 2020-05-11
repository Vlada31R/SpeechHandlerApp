//
//  UIStoryboard+ViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static let loginFlowStoryboard = UIStoryboard(name: "Login", bundle: nil)
    static let mainFlowStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {

        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
        else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}

protocol StoryboardIdentifiable {

    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
