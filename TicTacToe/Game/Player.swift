//
//  Player.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

enum Player {
    case cross
    case nought
    
    var symbol: GameSymbol {
        switch self {
        case .cross:
            return .cross
        case .nought:
            return .tought
        }
    }

    var opposite: Player {
        switch self {
        case .cross:
            return .nought
        case .nought:
            return .cross
        }
    }
}
