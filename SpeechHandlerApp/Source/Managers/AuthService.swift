//
//  AuthService.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Firebase

class AuthService {

    var currentUser: User?
    
    func createUserDocument() {
        
        let db = Firestore.firestore()
        db.collection("users").document(currentUser?.uid ?? "").setData(["email" : currentUser?.email ?? ""])
    }
}
