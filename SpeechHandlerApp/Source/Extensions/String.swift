//
//  String.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

extension String {

    var isEmail: Bool {

        let isEmailAddressValid = (self.range(of: "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$",
                                              options: .regularExpression) != nil)

        return isEmailAddressValid
    }
}
