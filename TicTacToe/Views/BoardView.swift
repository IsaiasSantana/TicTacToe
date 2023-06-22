//
//  BoardView.swift
//  TicTacToe
//
//  Created by Isaías Santana on 21/06/23.
//

import SwiftUI


struct BoardView: View {
    @ObservedObject private var viewModel: TicTacToeViewModel

    init(viewModel: TicTacToeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<viewModel.boardSize, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.boardSize, id: \.self) { column in
                        let content = viewModel.contentRows[row, column]
                        RowView(rowContent: content, action: {
                            Task {
                               await viewModel.makeMove(row: row, column: column)
                            }
                        })
                    }
                }
            }
        }
        .background(.black)
        .padding()
    }
}
