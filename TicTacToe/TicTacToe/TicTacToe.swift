//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-21.
//

import Foundation

struct TicTacToe {
    private var playerInTurn: Player = .X
    
    var piecesBox: Set<Piece> = []
    
    func pieceAt(col: Int, row: Int) -> Piece? {
        for piece in piecesBox {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil
    }
    
    mutating func dropAt(col: Int, row: Int) {
        guard pieceAt(col: col, row: row) == nil else {
            return
        }
    
        piecesBox.insert(Piece(col: col, row: row, player: playerInTurn))
        playerInTurn = playerInTurn.isX() ? .O : .X
    }
}

extension TicTacToe: CustomStringConvertible {
    var description: String {
        var desc = ""
        
        for i in 0..<3 {
            let row = 2 - i
            desc += "\(row)"
            for col in 0..<3 {
                if let piece = pieceAt(col: col, row: row) {
                    desc += piece.player.isX() ? " X" : " O"
                } else {
                    desc += " ."
                }
            }
            desc += "\n"
        }
        desc += "  0 1 2"

        return desc
    }
}
