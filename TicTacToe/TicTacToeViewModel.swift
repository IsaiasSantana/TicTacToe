//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class TicTacToeViewModel: ObservableObject {
    private let game = TicTacToeGame(initialPlayer: .cross)
    private var isMarking = false
    private var subscriptions = Set<AnyCancellable>()
    
    var boardSize: Int {
        TicTacToeGame.boardSize
    }
    
    @Published var contentRows = RowViewContentMatrix(rows: TicTacToeGame.boardSize, columns: TicTacToeGame.boardSize)
    @Published var turnMessage = "It's your turn."
    @Published var titleMessage = ""
    @Published var showAlert = false
    
    @Published var aiLevelOptions: [AILevel] = [.impossible, .normal]
    @Published var selectedAILevel = AILevel.impossible
    
    @Published var initialPlayer = Player.cross
    @Published var playerOptions = [Player.cross, Player.nought]

    init() {
        $selectedAILevel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshBoard()
            }.store(in: &subscriptions)
        
        $initialPlayer
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshBoard()
            }.store(in: &subscriptions)
    }
    
    func makeMove(row: Int, column: Int) async {
        guard game.canDoMoviment((row, column)) else {
            return
        }

        guard isMarking == false else {
            return
        }
        
        guard !game.isDraw() || !game.hasWinner() else {
            return
        }
    
        isMarking = true

        updateContentRow(at: (row, column), player: game.currentBoard.player)
        game.makeMove((row, column))
        
        if game.hasWinner() || game.isDraw() {
            checkWinnerOrDraw()
            updateTurnMessage()
        } else {
            isMarking = false
            await makeAIMoviment()
        }
    }
    
    private func updateContentRow(at position: Move, player: Player) {
        contentRows[position.row, position.column] = .init(mark: player.symbol.rawValue)
    }
    
    private func checkWinnerOrDraw() {
        showAlert = game.hasWinner() || game.isDraw()
        if game.hasWinner() {
            titleMessage = "Player \(game.currentBoard.player.opposite.symbol.rawValue) Win!"
        } else if game.isDraw() {
            titleMessage = "Draw!"
        }
    }
    
    private func updateTurnMessage() {
        if game.hasWinner() || game.isDraw() {
            turnMessage = titleMessage
            return
        }
        
        if game.currentBoard.player == .cross {
            turnMessage = "It's your turn"
        } else {
            turnMessage = "It's AI turn"
        }
    }

    private func makeAIMoviment() async {
        guard isMarking == false else {
            return
        }
        isMarking = true
        updateTurnMessage()
        guard let aiMove = game.makeAIMoviment(difficulty: selectedAILevel) else {
            return
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.updateContentRow(at: aiMove, player: .nought)
                self?.isMarking = false
                self?.checkWinnerOrDraw()
                self?.updateTurnMessage()
            }
        }
    }

    func refreshBoard() {
        isMarking = false
        game.resetBoard(initalPlayer: initialPlayer)
        contentRows = RowViewContentMatrix(rows: TicTacToeGame.boardSize, columns: TicTacToeGame.boardSize)
        showAlert = false
        updateTurnMessage()
        makeAiMovimentIfNeeded()
    }

    private func makeAiMovimentIfNeeded() {
        if initialPlayer == .nought {
            Task {
                await makeAIMoviment()
            }
        }
    }
}
