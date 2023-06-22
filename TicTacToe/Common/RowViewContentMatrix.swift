//
//  RowViewContentMatrix.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

struct RowViewContentMatrix {
    let rows: Int
    let columns: Int
    private var grid: [RowViewContent]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: .init(), count: rows * columns)
    }

    subscript(row: Int, column: Int) -> RowViewContent {
        get {
            return grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
}
