//
//  LoginView.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 6/17/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var userIsLoggedIn: Bool
    @State var showFields = false
    @State var first_name = ""
    @State var last_name = ""
    @State var profileAlert = false
    
    var body: some View {
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                if !showFields {
                    Spacer()
                }
                Image("Mintaylorham")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.cyan)
                Text("Start your journey to healthier plants")
                    .font(.system(size: 20))
                Spacer()
                if showFields {
                    TextInputView("First Name", text: $first_name)
                    TextInputView("Last Name", text: $last_name)
                    Spacer()
                }
                if !showFields {
                    Button {
                        showFields.toggle()
                    } label: {
                        Text("Set Up Profile")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 26))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2))
                    }
                } else {
                    Button {
                        if first_name != "" {
                            userIsLoggedIn.toggle()
                        } else {
                            profileAlert.toggle()
                        }
                        
                    } label: {
                        Text("Create Profile")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 26))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2))
                    }
                    .alert(isPresented: $profileAlert) {
                        Alert(title: Text("Please Enter First Name"))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(userIsLoggedIn: .constant(false))
}
