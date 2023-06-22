//
//  Matrix.swift
//  TicTacToe
//
//  Created by Isaías Santana on 22/06/23.
//

import Foundation

struct Matrix {
    let rows: Int
    let columns: Int
    private var grid: [GameSymbol]
    
    var isEmpty: Bool {
        grid.isEmpty
    }

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: .empty, count: rows * columns)
    }

    subscript(row: Int, column: Int) -> GameSymbol {
        get {
            return grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
}
