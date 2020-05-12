//
//  ShadowButton.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/12/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {

var shadowLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()

        guard shadowLayer == nil else { return }

        let tempLayer = CAShapeLayer()
        tempLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
        tempLayer.fillColor = UIColor.white.cgColor

        tempLayer.shadowColor = UIColor.black.cgColor
        tempLayer.shadowPath = tempLayer.path
        tempLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tempLayer.shadowOpacity = 0.16
        tempLayer.shadowRadius = 2

        shadowLayer = tempLayer

        layer.insertSublayer(tempLayer, at: 0)
    }
}
