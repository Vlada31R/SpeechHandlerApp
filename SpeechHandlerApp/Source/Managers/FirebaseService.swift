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

    func save(model: TrackModel) -> String? {

        let doc = currentUserTracks?.addDocument(data: model.model())
        return doc?.documentID
    }
    
    func deleteTrack(id: String) {
        
        currentUserTracks?.document(id).delete()
    }
    
    func downloadModels(completion: @escaping ([TrackModel])->()) {
        
        currentUserTracks?.getDocuments(completion: { (snapshot, error) in
            
            guard error == nil,
                  let docSnapshot = snapshot
            else {
                completion([])
                return
            }
            
            var models: [TrackModel] = []
            docSnapshot.documents.forEach { doc in
                let model = self.decodeTrack(id: doc.documentID, from: doc.data())
                
                if let model = model {
                    models.append(model)
                }
            }
            completion(models)
        })
    }
}

private extension FirebaseService {
    
    func decodeTrack(id: String, from data: [String : Any]) -> TrackModel? {
        
        guard let name = data["name"] as? String,
              let containerFileName = data["containerFileName"] as? String,
              let isTransformed = data["isTransformed"] as? Bool
        else { return nil }
        
        let model = TrackModel(trackId: id,
                                  name: name,
                           description: data["description"] as? String,
                     containerFileName: containerFileName,
                         isTransformed: isTransformed,
                                  text: data["text"] as? String)
        return model
    }
}
