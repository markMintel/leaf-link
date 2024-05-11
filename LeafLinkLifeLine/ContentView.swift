//
//  ContentView.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 5/11/24.
//

import SwiftUI

struct ContentView: View {
    //@State var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    //private var users: [User] = User.allUsers
    //var user = User.sampleUser
    @AppStorage("user") var isLoggedIn: Bool = false
    @AppStorage("profileCreated") var userIsLoggedIn: Bool = (UserDefaults.standard.object(forKey: "profileCreated") != nil)
    
    
    
    
    var body: some View {
        if userIsLoggedIn {
            //Text("\(user.first_name) logged in")
            Text("User is logged in")
            Button {
                userIsLoggedIn = false
                //UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
            } label: {
                Text("Log Out")
                    .foregroundColor(.red)
            }
        } else {
            Text("They are not logged in")
            Button {
                userIsLoggedIn = true
                //UserDefaults.standard.set(true, forKey: "isLoggedIn")
            } label: {
                Text("Login")
            }
        }
    }
}


#Preview {
    ContentView()
}
