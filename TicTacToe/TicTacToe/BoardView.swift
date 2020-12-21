//
//  BoardView.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit

class BoardView: UIView {
    
    var ticTacToeDelegate: TicTacToeDelegate?
    
    private var halfCellSide: CGFloat = -1
    private var ratio: CGFloat = 0.7

    override func draw(_ rect: CGRect) {
        halfCellSide = bounds.width / 6
        drawBoard()
        drawPieces()
    }
    
    private func drawPieces() {
        for row in 0..<2 {
            for col in 0..<2 {
                if let piece = ticTacToeDelegate?.pieceAt(col: col, row: row) {
                    if piece.player.isX() {
                        drawX(col: col, row: row)
                    } else {
                        drawO(col: col, row: row)
                    }
                }
            }
        }
    }
    
    private func drawX(col: Int, row: Int) {
        let center = centerOf(col: col, row: row)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: center.x - halfCellSide * ratio, y: center.y - halfCellSide * ratio))
        path.addLine(to: CGPoint(x: center.x + halfCellSide * ratio, y: center.y + halfCellSide * ratio))
        
        path.move(to: CGPoint(x: center.x + halfCellSide * ratio, y: center.y - halfCellSide * ratio))
        path.addLine(to: CGPoint(x: center.x - halfCellSide * ratio, y: center.y + halfCellSide * ratio))
        
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        path.lineWidth = 5
        path.stroke()
    }
    
    private func drawO(col: Int, row: Int) {
        let center = centerOf(col: col, row: row)
        let path = UIBezierPath(arcCenter: CGPoint(x: center.x, y: center.y), radius: halfCellSide * ratio, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        path.lineWidth = 5
        path.stroke()
    }
    
    private func centerOf(col: Int, row: Int) -> CGPoint {
        return CGPoint(x: halfCellSide + CGFloat(col) * 2 * halfCellSide, y: halfCellSide + CGFloat(2 - row) * 2 * halfCellSide)
    }
    
    private func drawBoard() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: bounds.height/3))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height/3))
        
        path.move(to: CGPoint(x: 0, y: bounds.height * 2/3))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 2/3))
        
        path.move(to: CGPoint(x: bounds.width/3, y: 0))
        path.addLine(to: CGPoint(x: bounds.width/3, y: bounds.height))
        
        path.move(to: CGPoint(x: bounds.width * 2/3, y: 0))
        path.addLine(to: CGPoint(x: bounds.width * 2/3, y: bounds.height))
        
        path.lineWidth = 3
        #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1).setStroke()
        path.stroke()
    }

}
