//
//  ViewAudioViewController.swift
//  SpeechHandlerApp
//
//  Created by radchenko on 24.05.2020.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import JGProgressHUD
import AVFoundation

protocol ViewAudioViewControllerDelegate: class {
    
    func viewAudioViewController(_ viewController: ViewAudioViewController, didUpdate model: TrackModel)
}

class ViewAudioViewController: BaseViewController {
    
    var trackModel: TrackModel!
    var networkManager: NetworkManager!
    var firebaseService: FirebaseService!

    weak var delegate: ViewAudioViewControllerDelegate?
    
    fileprivate var player: AVAudioPlayer?
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var transformedTextLabel: UILabel!
    @IBOutlet private weak var areNotTransformedLabel: UILabel!
    @IBOutlet private weak var transformButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialUI()
    }
    
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        
        let filePath = self.getDocumentsDirectory().appendingPathComponent(trackModel.containerFileName)
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            
            do {
                player = try AVAudioPlayer(contentsOf: filePath)
                player?.play()
            } catch {
                self.showAlert(message: "Something went wrong.")
            }
        } else {
            firebaseService.download(fileName: trackModel.containerFileName) { url in
                if let fileUrl = url {
                    do {
                        self.player = try AVAudioPlayer(contentsOf: fileUrl)
                        self.player?.play()
                    } catch {
                        self.showAlert(message: "Something went wrong.")
                    }
                } else {
                    self.showAlert(message: "Couldn't get audiofile.")
                }
            }
        }
    }
    
    @IBAction func didTapTransformButton(_ sender: UIButton) {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Transforming"
        hud.show(in: self.view)
        
        let filePath = self.getDocumentsDirectory().appendingPathComponent(trackModel.containerFileName)

        networkManager.postData(input: trackModel,
                                 data: try! Data(contentsOf: filePath),
                             fileName: trackModel.containerFileName) { response in

                                    Timer.scheduledTimer(withTimeInterval: TimeInterval(response?.check_wait ?? 30),
                                                         repeats: false) { timer in

                                        let job = Job(id: response?.id ?? 0)

                                        self.networkManager.getData(input: job) { response in

                                            let text = ConvertedText(text: response ?? "")
                                            self.trackModel.text = response

                                            self.networkManager.getData(input: text) { response in

                                                self.trackModel.text = response
                                                self.trackModel.isTransformed = true
                                                self.firebaseService.update(model: self.trackModel)
                                                
                                                hud.dismiss()
                                                
                                                self.setupInitialUI()
                                                self.delegate?.viewAudioViewController(self, didUpdate: self.trackModel)
                                            }
                                        }
                                    }
        }
    }
}

// MARK: - Private
private extension ViewAudioViewController {
    
    func setupInitialUI() {
        
        title = trackModel.name
        
        descriptionLabel.isHidden = trackModel.description == nil
        descriptionLabel.text = trackModel.description
        
        transformedTextLabel.isHidden = trackModel.text == nil
        transformedTextLabel.text = trackModel.text
        
        areNotTransformedLabel.isHidden = trackModel.isTransformed
        transformButton.isHidden = trackModel.isTransformed
    }
    
    func getDocumentsDirectory() -> URL {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
