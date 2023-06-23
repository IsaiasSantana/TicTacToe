//
//  Strings.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

struct Strings {
    static let playerTurn = "It's Your turn"
    static let aiTurn = "It's AI turn"
    static let playerWin = "Player X win!"
    static let aiWin = "AI win!"
    static let draw = "Draw!"
    
    static func winMessage(for player: Player) -> String {
        switch player {
        case .cross:
            return playerWin
        case .nought:
            return aiWin
        }
    }
}
