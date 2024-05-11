//
//  Settings.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 6/3/24.
//


import SwiftUI

struct Settings: View {
    @AppStorage("first_name") var first_name: String = (UserDefaults.standard.string(forKey: "first_name") ?? "User")
    @AppStorage("last_name") var last_name: String = (UserDefaults.standard.string(forKey: "last_name") ?? "User")
    
    @State var is_first_name = false
    @State var is_last_name = false
    @State var new_first_name = ""
    @State var new_last_name = ""
    @Environment(CoreViewModel.self) var user_plants: CoreViewModel
    
    var body: some View {
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                Image("Mintaylorham")
                    .resizable()
                    .frame(width: 300, height: 300)
                Text("First Name: \(first_name)")
                    .foregroundColor(.white)
                Text("Last Name: \(last_name)")
                    .foregroundColor(.white)
                Button {
                    is_first_name.toggle()
                } label: {
                    ButtonLabelView(text: "Edit First Name")
                        .cornerRadius(50)
                        .frame(width:300)
                        
                    }
                if is_first_name {
                    TextInputView("First Name", text: $new_first_name)
                        .frame(width: 150)
                }
                Button {
                    is_last_name.toggle()
                } label: {
                    ButtonLabelView(text: "Edit Last Name")
                        .cornerRadius(50)
                        .frame(width:300)
                        .padding()
                }
                if is_last_name {
                    TextInputView("Last Name", text: $new_last_name)
                        .frame(width: 150)
                        .padding()
                }
                
                
                //Spacer()
//                Button {
//                    shouldShowLogOutOptions.toggle()
//                } label: {
//                    HStack {
//                        Spacer()
//                        Text("Log Out")
//                            .foregroundColor(.white)
//                            .padding(.vertical, 10)
//                            .font(.system(size: 18, weight: .semibold))
//                        Spacer()
//                    }
//                    .background(Color.red)
//                    .cornerRadius(25)
//                    .frame(width:300)
//                }
                if is_first_name || is_last_name {
                    Button {
                        if self.new_first_name != "" {
                            first_name = new_first_name
                        }
                        if self.new_last_name != "" {
                            last_name = new_last_name
                        }
                        self.is_first_name = false
                        self.is_last_name = false
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save Changes")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.orange)
                            .frame(width: 150)
                            .cornerRadius(50)
                    }
                }
            }//End Vstack
//            .actionSheet(isPresented: $shouldShowLogOutOptions) {
//                .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
//                    .destructive(Text("Sign Out"), action: {
//                        print("handle sign out")
//                        try? Auth.auth().signOut()
//                        self.isUserCurrentlyLoggedOut = false
//                    }),
//                    .cancel()
//                ])
//            }
        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Settings().environment(CoreViewModel())
    }
}
