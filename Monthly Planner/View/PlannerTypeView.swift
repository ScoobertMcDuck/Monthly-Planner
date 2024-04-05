//
//  PlannerTypeView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/4/24.
//

import SwiftUI
import Firebase

struct PlannerTypeView: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button {
            try! Auth.auth().signOut()
            
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

#Preview {
    PlannerTypeView()
}
