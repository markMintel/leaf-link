//
//  ImageOffset.swift
//  PlantHealth
//
//  Created by Mark Mintel on 5/3/24.
//

import Foundation

struct Offset {
    private var icon_name: String
    var offset: Int = 0
    
    init(icon_name: String) {
        self.icon_name = icon_name
        
        switch self.icon_name {
        case "plant1":
                self.offset = 15
        case "plant2":
            self.offset = 3
        case "plant3":
            self.offset = -5
        case "monstera":
            self.offset = 13
        default:
            self.offset = 0
        }
        
    }
    
}
