//
//  DailyBottomView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import SwiftUI
import Firebase

struct DailyBottomView: View {
    
    @ObservedObject var model = documentRetrieval()
    @ObservedObject var collectionsModel = CollectionsViewModel()
    @State private var showingAlert = false
    @State private var text = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Notes:")
                        .font(.custom("ArialRoundedMTBold", fixedSize: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Add note
                    Button ("+") {
                        showingAlert.toggle()
                    }
                    .font(.custom("ArialRoundedMTBold", fixedSize: 25))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .alert("Note being Added:", isPresented: $showingAlert) {
                        TextField("Text", text: $text)
                        Button("Add", action: addNotes)
                    }

                }
                .frame(height: geometry.size.height * 0.10)
                Text("  " + model.notesArray.notes)
                    .font(.custom("ArialRoundedMTBold", fixedSize: 20))
                    .frame(maxWidth: 375, alignment: .topLeading)
                    .frame(maxHeight: geometry.size.height * 0.80)
                    .background(Color(.blue))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
    }
    
    init() {
        model.getNotes()
    }
    
    // Add notes
    func addNotes() {
        
        // Update notes
        let db = Firestore.firestore()
        let docRef = db.collection(collectionsModel.getID()).document("Notes")
        docRef.setData(["notes": text], merge: true)
        
        // Turn off Alert
        showingAlert.toggle()
        text = ""
    }
}

#Preview {
    DailyBottomView()
}




