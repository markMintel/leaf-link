//
//  ButtonLabelView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/13/24.
//

import SwiftUI

struct ButtonLabelView: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }.background(Color.green)
    }
}
