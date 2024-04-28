//
//  WeeklyView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/26/24.
//

import SwiftUI

struct WeeklyView: View {
    var body: some View {
        GeometryReader { geometry in
            // Main Container
            VStack(spacing: 0) {
                
                // Top Header
                Text("WeeklyPlanner")
                    .font(.custom("ArialRoundedMTBold", fixedSize: 28))
                    .frame(height: geometry.size.height * 0.15)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Main Section
                HStack {
                    WeeklyLeftSide()
                    WeeklyRightSide()
                }
                    .frame(height: geometry.size.height * 0.85)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        } .frame(width: 375)
    }
}

#Preview {
    WeeklyView()
}
