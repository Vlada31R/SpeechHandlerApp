//
//  SaveAudioViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol SaveAudioViewControllerDelegate: class {

    func saveAudioViewControllerDidCancel(_ viewController: SaveAudioViewController)
}

class SaveAudioViewController: BaseViewController {

    var filePath: URL!

    weak var delegate: SaveAudioViewControllerDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var transformSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialUI()
    }

    @IBAction func didTapSaveButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {

        self.showDiscardChangesAlert { [weak self] in

            guard let strongSelf = self else { return }

            try? FileManager.default.removeItem(at: strongSelf.filePath)

            strongSelf.delegate?.saveAudioViewControllerDidCancel(strongSelf)
        }
    }
}

private extension SaveAudioViewController {

    func setupInitialUI() {

        title = "Save"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<AudioList", style: .plain, target: self, action: #selector(didTapCancelButton))
    }
}
