//
//  AudioTrackTableViewCell.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

class AudioTrackTableViewCell: BaseTableViewCell {

    @IBOutlet private var nameLabel: UILabel!

    func configCell(name: String) {
        nameLabel.text = name
    }
}
