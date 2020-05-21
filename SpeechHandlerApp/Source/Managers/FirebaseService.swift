//
//  FirebaseService.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/21/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    fileprivate var authService: AuthService
    fileprivate let db = Firestore.firestore()
    fileprivate var currentUserTracks: CollectionReference?

    init(authService: AuthService) {

        self.authService = authService
        currentUserTracks = db.collection("users").document(authService.currentUser?.uid ?? "").collection("tracks")
    }

    func save(model: TrackModel) {

        currentUserTracks?.addDocument(data: model.model())
    }
}
