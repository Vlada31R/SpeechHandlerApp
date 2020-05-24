//
//  SaveAudioViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol SaveAudioViewControllerDelegate: class {

    func saveAudioViewControllerDidCancel(_ viewController: SaveAudioViewController)
    func saveAudioViewController(_ viewController: SaveAudioViewController, didSave model: TrackModel)
}

class SaveAudioViewController: BaseViewController {

    var filePath: URL!
    var networkManager: NetworkManager!
    var firebaseService: FirebaseService!

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

        var trackModel = TrackModel(name: trackName,
                             description: descriptionTextField.text,
                       containerFileName: filePath.lastPathComponent,
                           isTransformed: transformSwitch.isOn)

        guard transformSwitch.isOn
        else {
            let docId = self.firebaseService.save(model: trackModel)
            trackModel.trackId = docId
            
            self.delegate?.saveAudioViewController(self, didSave: trackModel)
            
            return
        }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Transforming"
        hud.show(in: self.view)

        networkManager.postData(input: trackModel,
                                data: try! Data(contentsOf: filePath),
                                fileName: filePath.lastPathComponent) { response in

                                    Timer.scheduledTimer(withTimeInterval: TimeInterval(response?.check_wait ?? 30),
                                                         repeats: false) { timer in

                                        let job = Job(id: response?.id ?? 0)

                                        self.networkManager.getData(input: job) { response in

                                            let text = ConvertedText(text: response ?? "")
                                            trackModel.text = response

                                            self.networkManager.getData(input: text) { response in

                                                trackModel.text = response
                                                let docId = self.firebaseService.save(model: trackModel)
                                                trackModel.trackId = docId
                                                
                                                hud.dismiss()
                                                
                                                self.delegate?.saveAudioViewController(self, didSave: trackModel)
                                            }
                                        }
                                    }
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
