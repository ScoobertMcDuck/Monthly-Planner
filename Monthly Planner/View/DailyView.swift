//
//  DailyView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/26/24.
//

import SwiftUI

struct DailyView: View {
    var body: some View {
        
        GeometryReader { geometry in
            // Main Container
            VStack {
                
                // Top Header
                DailyTopView()
                    .frame(height: geometry.size.height * 0.15)
                    .frame(width: 375)
                
                // Main Section
                DailyMainView()
                    .frame(height: geometry.size.height * 0.65)
                    .frame(width: 375)
                
                // Notes Section
                DailyBottomView()
                    .frame(height: geometry.size.height * 0.20)
                    .frame(width: 375)
            }
        } .frame(width: 375)
    }
}

#Preview {
    DailyView()
}
