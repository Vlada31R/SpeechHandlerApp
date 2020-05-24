//
//  AudioListViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Async

protocol AudioListViewControllerDelegate: class {

    func audioListViewControllerDidCreateNewTrack(_ viewController: AudioListViewController)
    func audioListViewController(_ viewController: AudioListViewController, didSelectAudio audio: TrackModel)
}

class AudioListViewController: BaseViewController {

    var firebaseService: FirebaseService!
    weak var delegate: AudioListViewControllerDelegate!

    var trackModels: [TrackModel] = [] {
        didSet {
            self.reloadUI()
        }
    }

    @IBOutlet private weak var listTableView: UITableView!
    @IBOutlet private weak var emptyContentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialUI()
    }

    @IBAction func didTapDownloadButton(_ sender: UIButton) {
        
        firebaseService.downloadModels { models in
            
            guard !models.isEmpty
            else {
               self.showAlert(message: "Your tracks list is empty or something went wrong.")
               return
            }
            
            self.trackModels = models
        }
    }

    @IBAction func didTapCreateNewButton(_ sender: UIButton) {

        delegate?.audioListViewControllerDidCreateNewTrack(self)
    }

    @objc func didTapMenuButton() {

    }
}

// MARK: - UITableViewDelegate
extension AudioListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = trackModels[indexPath.row]
        delegate?.audioListViewController(self, didSelectAudio: model)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete
        else {
            return
        }
        
        self.deleteTrack(at: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension AudioListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(with: AudioTrackTableViewCell.self, for: indexPath)
        cell.configCell(name: trackModels[indexPath.row].name)
        return cell
    }
}

// MARK: - Private
private extension AudioListViewController {

    func setupInitialUI() {

        title = "Audiolist"

        let menuBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTapMenuButton))
            return barButtonItem
        }()

        let addBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapCreateNewButton))
            return barButtonItem
        }()

        navigationItem.leftBarButtonItem = menuBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem

        listTableView.register(cellType: AudioTrackTableViewCell.self)
    }

    func reloadUI() {

        emptyContentView.isHidden = !trackModels.isEmpty
        listTableView.isHidden = trackModels.isEmpty
        listTableView.reloadData()
    }
    
    func deleteTrack(at index: Int) {
        
        let delete: (UIAlertAction) -> () = { action in
            
            self.firebaseService.deleteTrack(id: self.trackModels[index].trackId ?? "")
            self.trackModels.remove(at: index)
        }
        
        let alert = UIAlertController(title: "Are you sure that you want to delete \(trackModels[index].name) track?",
                                    message: "",
                             preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Close",
                                         style: .default,
                                       handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive,
                                       handler: delete)

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        Async.main {
            self.present(alert, animated: true)
        }
    }
}
