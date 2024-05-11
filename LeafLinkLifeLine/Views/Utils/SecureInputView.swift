//
//  SecureInputView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/13/24.
//
import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {

            if isSecured {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundColor(.white)
                            .bold()
                            
                    }
                    .autocapitalization(.none)
            } else {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundColor(.white)
                            .bold()
                            
                    }
                    .autocapitalization(.none)
            }

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.white)
            }
        }
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.white)
    }
}
