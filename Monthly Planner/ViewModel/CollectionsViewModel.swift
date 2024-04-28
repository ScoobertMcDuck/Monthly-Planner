//
//  CollectionsViewModel.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/28/24.
//

import Foundation
import Firebase

class CollectionsViewModel: ObservableObject {
    
    
    // Get UserID
    func getID() -> String {
        guard let userID = Auth.auth().currentUser?.uid
        else { return "No ID" }
        return userID
    }
    
    // Get Notes from database
    func createDocs() {
        
        let userID = getID()
        
        // Database reference
        let db = Firestore.firestore()
        
        // Create notes document
        var docRef = db.collection(userID).document("Notes")
        docRef.setData(["notes": ""])
        
        // Create daily to do list document
        docRef = db.collection(userID).document("DailyTDL")
        docRef.setData(["dailyList": []])
        
        // Create tasks document
        docRef = db.collection(userID).document("Tasks")
        docRef.setData([
            "nine": "",
            "ten": "",
            "eleven": "",
            "twelve": "",
            "thirteen": "",
            "fourteen": "",
            "fifteen": "",
            "sixteen": "",
            "seventeen": ""])
    }
}
