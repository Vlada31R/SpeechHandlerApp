//
//  AudioListViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol AudioListViewControllerDelegate: class {

}

class AudioListViewController: BaseViewController {

    var authService: AuthService!
    weak var delegate: AudioListViewControllerDelegate?

    @IBOutlet private weak var listTableView: UITableView!
    @IBOutlet weak var emptyContentView: UIView!
}
