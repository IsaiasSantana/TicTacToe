//
//  GameBoardTests.swift
//  TicTacToeTests
//
//  Created by Isaías Santana on 22/06/23.
//

import XCTest
@testable import TicTacToe

final class GameBoardTests: XCTestCase {
    func testMakeMoveAndThenNextPlayerShouldBeOppositePlayer() throws {
        let gameBoard = GameBoard(player: .cross)

        
        let newGameBoard = gameBoard.makeMove(row: 0, column: 0)
        
        XCTAssertEqual(gameBoard.player, .cross)
        XCTAssertEqual(newGameBoard.player, .nought)
    }
    
    func testIsDrawShouldBeTrue()  {
        let gameBoard = GameBoard(player: .cross)
            .makeMove(row: 0, column: 0) // X move
            .makeMove(row: 0, column: 1) // O Move
            .makeMove(row: 0, column: 2) // X Move
            .makeMove(row: 1, column: 2) // O Move
            .makeMove(row: 1, column: 0) // X Move
            .makeMove(row: 1, column: 1) // O Move
            .makeMove(row: 2, column: 1) // X Move
            .makeMove(row: 2, column: 0) // O Move
            .makeMove(row: 2, column: 2) // X Move
        
        XCTAssertTrue(gameBoard.isDraw())
    }
    
    func testHasWinnerShouldBeTrue() {
        let gameBoard = GameBoard(player: .cross)
            .makeMove(row: 0, column: 0) // X Move
            .makeMove(row: 1, column: 0) // O Move
            .makeMove(row: 0, column: 1) // X Move
            .makeMove(row: 1, column: 1) // O Move
            .makeMove(row: 0, column: 2) // X Move
        
        XCTAssertTrue(gameBoard.hasWinner())
        XCTAssertEqual(gameBoard.player.opposite, .cross)
        XCTAssertEqual(gameBoard.player, .nought)
    }
}
