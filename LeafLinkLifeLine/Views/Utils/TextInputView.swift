//
//  TextInputView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/13/24.
//

import SwiftUI

struct TextInputView: View {
    @Binding private var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                        
                }
                .autocapitalization(.none)
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundColor(.white)
        }
    }
    
}
