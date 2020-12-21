//
//  Piece.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-21.
//

import Foundation

struct Piece: Hashable {
    let col: Int
    let row: Int
    let player: Player
}
