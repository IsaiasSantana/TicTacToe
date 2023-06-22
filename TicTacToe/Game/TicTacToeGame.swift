//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

final class TicTacToeGame {
    private var gameBoard: GameBoard
    private let aiPlayer = AIPlayer()
    
    static var boardSize: Int {
        GameBoard.boardSize
    }
    
    
    var currentBoard: GameBoard {
        gameBoard
    }
    
    init(initialPlayer: Player) {
        self.gameBoard = GameBoard(player: initialPlayer)
    }
    
    func resetBoard(initalPlayer: Player = .cross) {
        gameBoard = GameBoard(player: initalPlayer)
    }

    func makeMove(_ move: Move) {
        guard canDoMoviment(move) else {
            return
        }

        gameBoard = gameBoard.makeMove(row: move.row, column: move.column)
    }
    
    func makeAIMoviment(difficulty: AILevel = .impossible) -> Move? {
        guard gameBoard.player == .nought else {
            return nil
        }

        guard let move = aiPlayer.makeMove(at: gameBoard, difficulty: difficulty) else {
            return nil
        }
        
        makeMove(move)
        
        return move
    }
    
    func canDoMoviment(_ move: Move) -> Bool {
        guard gameBoard.emptyPositions().isEmpty == false else {
            return false
        }
        
        guard gameBoard.isValidMove(move) else {
            return false
        }
    
        guard gameBoard.hasWinner() == false else {
            return false
        }
        
        guard gameBoard.isDraw() == false else {
            return false
        }

        return true
    }

    func hasWinner() -> Bool {
        gameBoard.hasWinner()
    }

    func isDraw() -> Bool {
        gameBoard.isDraw()
    }
}
