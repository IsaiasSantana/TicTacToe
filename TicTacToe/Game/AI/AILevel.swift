//
//  AILevel.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

enum AILevel {
    case normal
    case impossible
    
    var message: String {
        switch self {
        case .normal:
            return "Normal"
        case .impossible:
            return "Impossible"
        }
    }
}
