//
//  ViewAudioViewController.swift
//  SpeechHandlerApp
//
//  Created by radchenko on 24.05.2020.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol ViewAudioViewControllerDelegate: class {}

class ViewAudioViewController: BaseViewController {
    
    var trackModel: TrackModel!
    var networkManager: NetworkManager!
    var firebaseService: FirebaseService!

    weak var delegate: ViewAudioViewControllerDelegate?
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var transformedTextLabel: UILabel!
    @IBOutlet private weak var areNotTransformedLabel: UILabel!
    @IBOutlet private weak var transformButton: UIButton!
    
    @IBAction func didTapTransformButton(_ sender: UIButton) {
    }
}
