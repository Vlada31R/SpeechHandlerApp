//
//  RecordingViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Async
import AVFoundation

protocol RecordingViewControllerDelegate: class {

    func recordingViewController(_ viewController: RecordingViewController, recordAudioAt path: URL)
}

class RecordingViewController: BaseViewController {

    weak var delegate: RecordingViewControllerDelegate?

    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var filePath: URL?

    @IBOutlet private weak var recordingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recording"

        self.setupSession()
    }

    @IBAction func didTapRecordingButton(_ sender: UIButton) {

        guard recordingSession.recordPermission != .granted
        else {
            audioRecorder == nil ? startRecording() : finishRecording(success: true)
            return
        }

        recordingSession.requestRecordPermission() { [weak self] allowed in
            Async.main {

                guard let strongSelf = self else { return }

                guard allowed
                else {
                    strongSelf.showAlert(message: "App need record permissions for recording. Please allow it and try again.")
                    return
                }

                strongSelf.startRecording()
            }
        }
    }
}

// MARK: - AVAudioRecorderDelegate
extension RecordingViewController: AVAudioRecorderDelegate {

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

// MARK: - Private
private extension RecordingViewController {

    func startRecording() {

        let fileName = "\(Date())file.m4a"
        filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            guard let path = filePath else { return }

            audioRecorder = try AVAudioRecorder(url: path, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            audioRecorder.record()

            recordingButton.setTitle("Stop recording", for: .normal)
        } catch {
            self.finishRecording(success: false)
        }
    }

    func setupSession() {

        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            self.showAlert(message: "Something went wrong. Please try again later.")
        }
    }

    func finishRecording(success: Bool) {

        audioRecorder.stop()
        audioRecorder = nil

        if success, let path = filePath {
            delegate?.recordingViewController(self, recordAudioAt: path)
        } else {
            recordingButton.setTitle("Tap to Re-record", for: .normal)
        }
    }

    func getDocumentsDirectory() -> URL {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
