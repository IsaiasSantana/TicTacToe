//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

struct GameBoard {
    typealias BoardPosition = (row: Int, column: Int)
    static let boardSize = 3

    let player: Player
    let board: Matrix
    
    init(player: Player = .cross, board: Matrix = Matrix(rows: GameBoard.boardSize, columns: GameBoard.boardSize)) {
        self.player = player
        self.board = board
    }
    
    func makeMove(row: Int, column: Int) -> GameBoard {
        var newBoard = board
        newBoard[row, column] = player.symbol
        return GameBoard(player: player.opposite, board: newBoard)
    }
    
    func isValidMove(_ move: Move) -> Bool {
        board[move.row, move.column] == .empty
    }
    
    func isDraw() -> Bool {
        emptyPositions().isEmpty && !hasWinner()
    }
    
    func isEmpty() -> Bool {
        board.isEmpty
    }
    
    func emptyPositions() -> [BoardPosition] {
        var result = [BoardPosition]()
        for row in 0..<board.rows {
            for column in 0..<board.columns {
                if board[row, column] == .empty {
                    result.append((row, column))
                }
            }
        }
        return result
    }
    
    func hasWinner() -> Bool {
        hasWinnerOnRows() || hasWinnerOnColumns() || hasWinnerOnDiagonals()
    }
    
    private func hasWinnerOnRows() -> Bool {
        for row in 0..<board.rows {
            var set = Set<GameSymbol>()
            for column in 0..<board.columns {
                set.insert(board[row, column])
            }
            
            if set.count == 1 && set.first != .empty {
                return true
            }
        }
        return false
    }
    
    private func hasWinnerOnColumns() -> Bool {
        for column in 0..<board.columns {
            var set = Set<GameSymbol>()
            for row in 0..<board.rows {
                set.insert(board[row, column])
            }
            
            if set.count == 1 && set.first != .empty {
                return true
            }
        }
        return false
    }
    
    private func hasWinnerOnDiagonals() -> Bool {
        func hasWinnerOnMainDiagonal() -> Bool {
            var set = Set<GameSymbol>()
            for row in 0..<board.rows {
                for column in 0..<board.columns {
                    if row == column {
                        set.insert(board[row, column])
                    }
                }
            }
            return set.count == 1 && set.first != .empty
        }
        
        func hasWinnerOnSecondaryDiagonal() -> Bool {
            var set = Set<GameSymbol>()
            for row in 0..<board.rows {
                for column in 0..<board.columns {
                    if (row + column) == (GameBoard.boardSize - 1) {
                        set.insert(board[row, column])
                    }
                }
            }
            return set.count == 1 && set.first != .empty
        }

        return hasWinnerOnMainDiagonal() || hasWinnerOnSecondaryDiagonal()
    }
}
