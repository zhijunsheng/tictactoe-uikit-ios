//
//  TicTacToeDelegate.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-21.
//

import Foundation

protocol TicTacToeDelegate {
    func pieceAt(col: Int, row: Int) -> Piece?
}
