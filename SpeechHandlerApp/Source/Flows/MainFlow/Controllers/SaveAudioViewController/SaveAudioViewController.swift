//
//  SaveAudioViewController.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

protocol SaveAudioViewControllerDelegate: class {
}

class SaveAudioViewController: BaseViewController {

    var filePath: URL!

    weak var delegate: SaveAudioViewControllerDelegate?
}
