//
//  TextView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import SwiftUI

struct TextView: View {
    let item: String
    @State private var strike = false
    var body: some View {
        Text("  \u{2022} " + item)
            .frame(maxWidth: .infinity, alignment: .leading)
            .strikethrough(strike)
            .onTapGesture(perform: {
                self.strike.toggle()
            })
    }
}

#Preview {
    TextView(item: "doogie")
}
