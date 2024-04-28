//
//  DailyMainView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import SwiftUI
import Firebase

struct DailyMainView: View {
    
    @ObservedObject var model = documentRetrieval()
    @ObservedObject var quoteModel = QuoteViewModel()
    @State private var tdlAlert = false
    @State private var text = ""
    @State private var time = ""
    @State private var strike = false
    @State private var taskAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            // Main Container
            HStack {
                
                // Left Side
                VStack  {
                    
                    // List of Appointments
                    HStack {
                        Text("Tasks:")
                            .font(.custom("ArialRoundedMTBold", fixedSize: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Add task to list
                        Button ("+   ") {
                            taskAlert.toggle()
                        }
                        .font(.custom("ArialRoundedMTBold", fixedSize: 20))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .alert("Item being Added:", isPresented: $taskAlert) {
                            TextField("Time(HHHH)", text: $time)
                            TextField("Text", text: $text)
                            Button("Add", action: addTask)
                        }
                    }
                        .frame(height: geometry.size.height * 0.10)
                    
                    VStack (spacing: 30){
                        Text("  0900: " + model.taskList.nine)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1000: " + model.taskList.ten)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1100: " + model.taskList.eleven)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1200: " + model.taskList.twelve)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1300: " + model.taskList.thirteen)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1400: " + model.taskList.fourteen)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1500: " + model.taskList.fifteen)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1600: " + model.taskList.sixteen)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("  1700: " + model.taskList.seventeen)
                            .font(.custom("ArialRoundedMTBold", fixedSize: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: geometry.size.height * 0.90, alignment: .topLeading)
                        
                }
                .frame(width: geometry.size.width * 0.40)
                
                // Right Side
                VStack {
                    
                    // Quote of the Day
                    VStack (spacing: 0) {
                        Text("  Quotes to Live By:")
                            .font(.custom("ArialRoundedMTBold", fixedSize: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: geometry.size.height * 0.10)
                            .foregroundColor(.white)
                        Text("\"" + quoteModel.Quote + "\"")
                            .font(.custom("ArialRoundedMTBold", fixedSize: 15))
                            .frame(maxWidth: geometry.size.width * 0.40, alignment: .center)
                            .frame(height: geometry.size.height * 0.30, alignment: .topLeading)
                            .foregroundColor(.white)
                    }
                    .background(Color(.blue))
                    .cornerRadius(20)
                    
                    // To Do List
                    VStack (spacing: 0) {
                        HStack {
                            Text("  To Do List:")
                                .font(.custom("ArialRoundedMTBold", fixedSize: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: geometry.size.height * 0.12)
                                .foregroundColor(.white)
                            
                            // Add item to to do list
                            Button ("+   ") {
                                tdlAlert.toggle()
                            }
                            .font(.custom("ArialRoundedMTBold", fixedSize: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .alert("Item being Added:", isPresented: $tdlAlert) {
                                TextField("Text", text: $text)
                                Button("Add", action: addList)
                            }
                        }
                        VStack (spacing: 5) {
                            ForEach(model.dailyList.list, id: \.self) { item in
                                TextView(item: item)
                                    
                            }
                        }
                        .font(.custom("ArialRoundedMTBold", fixedSize: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: geometry.size.height * 0.50, alignment: .topLeading)
                        .foregroundColor(.white)
                    }
                    .background(Color(.blue))
                    .cornerRadius(20)
                    
                }
                
                
            }
        } .frame(width: 375)
        
        
    }
    
    init() {
        model.getList()
        model.getTasks()
        quoteModel.fetchData()
        
    }
    
    // Add notes
    func addList() {
        
        // Reference document
        let db = Firestore.firestore()
        let docRef = db.collection("TestCase").document("DailyTDL")
        
        // Get old list
        var newList = model.dailyList.list
        newList.append(text)
        
        docRef.setData(["dailyList": newList], merge: true)
        
        // Turn off Alert
        tdlAlert.toggle()
        text = ""
    }
    
    // Add notes
    func addTask() {
        
        // Reference document
        let db = Firestore.firestore()
        let docRef = db.collection("TestCase").document("meetings")
        
        // Add task
        let timeCon = convertTime(time)
        docRef.setData([timeCon: text], merge: true)
        
        // Turn off Alert
        taskAlert.toggle()
    }
    
    func convertTime(_ timeIn: String) -> String {
        
        // Convert input time from number to string
        let number = Int(timeIn.prefix(2))
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let stringOut = formatter.string(for: number)!
        
        return stringOut
    }
    
    
}

#Preview {
    DailyMainView()
}
