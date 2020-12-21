//
//  BoardView.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit

class BoardView: UIView {

    override func draw(_ rect: CGRect) {
        
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
