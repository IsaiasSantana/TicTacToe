//
//  Minimax.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

struct Minimax {
    private let win = 1
    private let loss = -1
    private let draw = 0

    func minimax(at board: GameBoard, currentPlayer: Player, depth: Int, alpha: Int, beta: Int, maximizing: Bool) -> Int {
        if board.hasWinner() && board.player.opposite == .nought {
            return win
        } else if board.hasWinner() && board.player.opposite == .cross {
            return loss
        } else if board.isDraw() {
            return draw
        }

        var alpha = alpha
        var beta = beta
        var bestEvaluation = maximizing ? Int.min : Int.max

        for emptyPosition in board.emptyPositions() {
            let newBoard = board.makeMove(row: emptyPosition.row, column: emptyPosition.column)
            let result = minimax(at: newBoard, currentPlayer: currentPlayer, depth: depth + 1, alpha: alpha, beta: beta, maximizing: !maximizing)
            
            if maximizing {
                bestEvaluation = max(bestEvaluation, result)
                alpha = max(alpha, bestEvaluation)
                
                if alpha >= beta {
                    return bestEvaluation
                }
                
            } else {
                bestEvaluation = min(bestEvaluation, result)
                beta = min(beta, bestEvaluation)
                
                if beta <= alpha {
                    return bestEvaluation
                }
            }
        }

        return bestEvaluation
    }
    
    func bestMove(at board: GameBoard, difficulty: AILevel = .impossible, maximizing: Bool = false) -> Move? {
        switch difficulty {
        case .normal:
            return chooseRandomMove(for: board, maximizing: maximizing)
        case .impossible:
            return chooseBestMove(for: board, maximizing: maximizing)
        }
    }
    
    private func chooseRandomMove(for board: GameBoard, maximizing: Bool) -> Move? {
        let isRandomMove = Bool.random()
        if isRandomMove {
            return board.emptyPositions().randomElement()
        } else {
            return chooseBestMove(for: board, maximizing: maximizing)
        }
    }
    
    private func chooseBestMove(for board: GameBoard, maximizing: Bool) -> Move? {
        var bestEvaluation = Int.min
        var bestMove: Move?
        
        let middlePosition = (1, 1)
        if board.isValidMove(middlePosition) {
            return middlePosition
        }

        for emptyPosition in board.emptyPositions() {
            let newBoard = board.makeMove(row: emptyPosition.row, column: emptyPosition.column)
            let result = minimax(at: newBoard, currentPlayer: board.player.opposite, depth: 0, alpha: Int.min, beta: Int.max, maximizing: maximizing)
            if result >= bestEvaluation {
                bestEvaluation = result
                bestMove = emptyPosition
            }
        }

        return bestMove
    }
}
