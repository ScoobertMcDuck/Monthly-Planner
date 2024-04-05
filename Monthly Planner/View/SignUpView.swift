//
//  ContentView.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/4/24.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
          PlannerTypeView()
        }
        
        else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color.blue
            
            RoundedRectangle(cornerRadius: 30, style:.continuous)
                .foregroundStyle(.linearGradient(colors: [.white, .white],
                    startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 600)
                .offset(y: -300)
            
            VStack(spacing: 20) {
                Image("Logo")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(y: -70)
                
                
                TextField("Email:", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email:")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password:")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    register()
                } label: {
                    Text("Create Account")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.white, .white],
                                    startPoint: .topLeading, endPoint: .bottomTrailing))
                            )
                }
                .padding(.top)
                
                Button {
                   login()
                } label: {
                    Text("Login Instead?")
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.top)

                
            }
            .frame(width : 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    // Login will probably navigate to new screen at final app
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    SignUpView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
