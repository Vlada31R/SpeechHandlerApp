//
//  RecordingViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol RecordingViewControllerDelegate: class {
    
}

class RecordingViewController: BaseViewController {

    weak var delegate: RecordingViewControllerDelegate?

    @IBOutlet private weak var recordingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recording"
    }

    @IBAction func didTapRecordingButton(_ sender: UIButton) {

        recordingButton.setTitle("Stop recording", for: .normal)
    }
}
