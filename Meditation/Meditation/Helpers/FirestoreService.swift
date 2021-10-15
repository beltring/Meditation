//
//  FirestoreService.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 14.10.21.
//

import CodableFirebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirestoreService {
    static let shared = FirestoreService()
    
    private init() {}
    private let user = Auth.auth().currentUser
    
    func createProperties(time: String) {
        guard let uid = user?.uid else { return }
        let model = UserProperties(timeLimit: time.convertToSeconds(), currentMeditationTime: 0, likeSongs: [], isContinue: false)
        let docData = try! FirestoreEncoder().encode(model)
        Firestore.firestore().collection("properties").document(uid).setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func createProperties(properties: UserProperties) {
        guard let uid = user?.uid else { return }
        let docData = try! FirestoreEncoder().encode(properties)
        Firestore.firestore().collection("properties").document(uid).setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
