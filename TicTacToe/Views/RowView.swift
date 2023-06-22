//
//  RowView.swift
//  TicTacToe
//
//  Created by Isaías Santana on 21/06/23.
//

import SwiftUI

struct RowViewContent {
    let mark: String

    init(mark: String = "") {
        self.mark = mark
    }
}

struct RowView: View {
    private let rowContent: RowViewContent
    private let action: () -> Void

    init(rowContent: RowViewContent, action: @escaping () -> Void) {
        self.rowContent = rowContent
        self.action = action
    }

    var body: some View {
        return Text(rowContent.mark)
            .font(.system(size: 64))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(.black)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    RowView(rowContent: .init(mark: "1")) { }
}
