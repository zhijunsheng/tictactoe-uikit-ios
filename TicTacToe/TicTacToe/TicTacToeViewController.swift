//
//  ViewController.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var ticTacToe = TicTacToe()
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.ticTacToeDelegate = self
        print(ticTacToe)
    }
}

extension TicTacToeViewController: TicTacToeDelegate {
    func pieceAt(col: Int, row: Int) -> Piece? {
        return ticTacToe.pieceAt(col: col, row: row)
    }
}
