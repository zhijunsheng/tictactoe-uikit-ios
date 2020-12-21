//
//  BoardView.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit

class BoardView: UIView {
    
    private var halfCellSide: CGFloat = -1
    private var ratio: CGFloat = 0.7

    override func draw(_ rect: CGRect) {
        halfCellSide = bounds.width / 6
        drawBoard()
        drawPieces()
    }
    
    private func drawPieces() {
        drawX()
        drawO()
    }
    
    private func drawX() {
        let cellCenterX: CGFloat = halfCellSide
        let cellCenterY: CGFloat = halfCellSide + 4 * halfCellSide
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: cellCenterX - halfCellSide * ratio, y: cellCenterY - halfCellSide * ratio))
        path.addLine(to: CGPoint(x: cellCenterX + halfCellSide * ratio, y: cellCenterY + halfCellSide * ratio))
        
        path.move(to: CGPoint(x: cellCenterX + halfCellSide * ratio, y: cellCenterY - halfCellSide * ratio))
        path.addLine(to: CGPoint(x: cellCenterX - halfCellSide * ratio, y: cellCenterY + halfCellSide * ratio))
        
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        path.lineWidth = 5
        path.stroke()
    }
    
    private func drawO() {
        let cellCenterX: CGFloat = halfCellSide + 2 * halfCellSide
        let cellCenterY: CGFloat = halfCellSide + 2 * halfCellSide
        let path = UIBezierPath(arcCenter: CGPoint(x: cellCenterX, y: cellCenterY), radius: halfCellSide * ratio, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        path.lineWidth = 5
        path.stroke()
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
