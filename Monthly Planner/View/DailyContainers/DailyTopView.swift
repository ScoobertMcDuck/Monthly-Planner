//
//  DailyTopView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import SwiftUI

struct DailyTopView: View {
    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                
                // Page Name
                Text("Daily Planner")
                    .font(.custom("ArialRoundedMTBold", fixedSize: 28))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Date Display
                VStack {
                    Text("Date:")
                        .font(.custom("ArialRoundedMTBold", fixedSize: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: geometry.size.height * 0.10)
                    Text(getDate())
                        .font(.custom("ArialRoundedMTBold", fixedSize: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: geometry.size.height * 0.40)
                        .background(Color(.blue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.frame(maxWidth: .infinity)
            }
        }
    }
    
    // Get Current Date
    func getDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d"
        let dateString = df.string(from: date)
        return dateString
    }
}

#Preview {
    DailyTopView()
}

