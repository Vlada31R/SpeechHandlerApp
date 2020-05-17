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
    func saveAudioViewController(_ viewController: SaveAudioViewController, didSave model: TrackModel)
}

class SaveAudioViewController: BaseViewController {

    var filePath: URL!
    var networkManager: NetworkManager!

    weak var delegate: SaveAudioViewControllerDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var transformSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialUI()
    }

    @IBAction func didTapSaveButton(_ sender: UIButton) {

        guard let trackName = nameTextField.text,
              !trackName.isEmpty
        else {
            self.showAlert(message: "Please enter track name")
            return
        }

        let trackModel = TrackModel(name: trackName,
                                    description: descriptionTextField.text,
                                    containerFileName: filePath.lastPathComponent)

        networkManager.postData(input: trackModel, data: try! Data(contentsOf: filePath), fileName: filePath.lastPathComponent){ response in
            self.delegate?.saveAudioViewController(self, didSave: trackModel)
        }
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
