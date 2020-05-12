//
//  AudioListViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol AudioListViewControllerDelegate: class {

    func audioListViewControllerDidCreateNewTrack(_ viewController: AudioListViewController)
}

class AudioListViewController: BaseViewController {

    var authService: AuthService!
    weak var delegate: AudioListViewControllerDelegate?

    private var trackModels: [TrackModel] = [] {
        didSet {
            self.reloadUI()
        }
    }

    @IBOutlet private weak var listTableView: UITableView!
    @IBOutlet weak var emptyContentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialUI()
    }

    @IBAction func didTapDownloadButton(_ sender: UIButton) {
    }

    @IBAction func didTapCreateNewButton(_ sender: UIButton) {

        delegate?.audioListViewControllerDidCreateNewTrack(self)
    }

    @objc func didTapMenuButton() {

    }
}

// MARK: - UITableViewDelegate
extension AudioListViewController: UITableViewDelegate {

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
}
