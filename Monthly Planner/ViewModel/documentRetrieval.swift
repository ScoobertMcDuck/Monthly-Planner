//
//  documentRetrieval.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import Foundation
import Firebase

class documentRetrieval: ObservableObject {
    
    @Published var notesArray = NotesModel(id: "", notes: "")
    @Published var dailyList = ListModel(id: "", list: [String]())
    @Published var taskList = MeetingsModel(id: "",
                                         nine: "",
                                         ten: "",
                                         eleven: "",
                                         twelve: "",
                                         thirteen: "",
                                         fourteen: "",
                                         fifteen: "",
                                         sixteen: "",
                                         seventeen: "")
    
    // Get Notes from database
    func getNotes() {
        
        // Database reference
        let db = Firestore.firestore()
        let docRef = db.collection("TestCase").document("Notes")
        
        // Get Data
        DispatchQueue.main.async {
            docRef.getDocument { document, error in
                
                // If error
                if let error = error  {
                     print(error)
                }
                
                // Read data
                else {
                    if let document = document {
                        let data = document.data()
                        return self.notesArray = NotesModel(
                            id: document.documentID,
                            notes: data?["notes"] as? String ?? "")
                    }
                }
            }
        }
    }
    
    // Get daily to do list from database
    func getList() {
        
        // Database reference
        let db = Firestore.firestore()
        let docRef = db.collection("TestCase").document("DailyTDL")
        
        // Get Data
        DispatchQueue.main.async {
            docRef.getDocument { document, error in
                
                // If error
                if let error = error  {
                     print(error)
                }
                
                // Read data
                else {
                    if let document = document {
                        let data = document.data()
                        return self.dailyList = ListModel(
                            id: document.documentID,
                            list: data?["dailyList"] as? [String] ?? [String]())
                    }
                }
            }
        }
    }
    
    // Get daily to do list from database
    func getTasks() {
        
        // Database reference
        let db = Firestore.firestore()
        let docRef = db.collection("TestCase").document("meetings")
        
        // Get Data
        DispatchQueue.main.async {
            docRef.getDocument { document, error in
                
                // If error
                if let error = error  {
                     print(error)
                }
                
                // Read data
                else {
                    if let document = document {
                        let data = document.data()
                        return self.taskList = MeetingsModel(
                            id: document.documentID,
                            nine: data?["nine"] as? String ?? "",
                            ten: data?["ten"] as? String ?? "",
                            eleven: data?["eleven"] as? String ?? "",
                            twelve: data?["twelve"] as? String ?? "",
                            thirteen: data?["thirteen"] as? String ?? "",
                            fourteen: data?["fourteen"] as? String ?? "",
                            fifteen: data?["fifteen"] as? String ?? "",
                            sixteen: data?["sixteen"] as? String ?? "",
                            seventeen: data?["seventeen"] as? String ?? "")
                    }
                }
            }
        }
    }
    
}
