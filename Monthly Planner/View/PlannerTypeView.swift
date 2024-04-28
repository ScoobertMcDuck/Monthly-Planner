//
//  PlannerTypeView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/4/24.
//

import SwiftUI
import Firebase

struct PlannerTypeView: View {
    
    @State private var userIsLoggedIn = true
    
    var body: some View {
        if userIsLoggedIn {
          content
        }
        
        else {
            SignUpView()
        }
    }
    
    var content: some View {
        VStack {
        
            NavigationStack {
                List {
                    NavigationLink {
                        MonthlyView()
                    } label: {
                        Text("Monthly Planner") }
                    NavigationLink {
                        WeeklyView()
                    } label: {
                        Text("Weekly Planner") }
                    NavigationLink {
                        DailyView()
                    } label: {
                        Text("Daily Planner") }
                }
            }
            Button {
                try! Auth.auth().signOut()
                userIsLoggedIn.toggle()
                
            } label: {
                Text("Sign Out")
                    .bold()
                    .frame(width: 200, height: 40)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.red, .red],
                                                  startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            }
            .padding(.top)
        }
    }
        
}

#Preview {
    PlannerTypeView()
}
