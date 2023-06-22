//
//  AIPlayer.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

final class AIPlayer {
    private let minimax: Minimax
    private var shouldMaximize = false

    init(minimax: Minimax = Minimax()) {
        self.minimax = minimax
    }

    func makeMove(at board: GameBoard, difficulty: AILevel = .impossible) -> Move? {
        if board.isEmpty(), shouldMaximize == false {
            shouldMaximize = true
        }
        return minimax.bestMove(at: board, difficulty: difficulty, maximizing: shouldMaximize)
    }
}
