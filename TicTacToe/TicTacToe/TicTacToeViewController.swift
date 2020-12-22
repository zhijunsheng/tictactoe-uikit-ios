//
//  ViewController.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit
import MultipeerConnectivity

class TicTacToeViewController: UIViewController {
    
    var ticTacToe = TicTacToe()
    
    private var peerID: MCPeerID!
    private var session: MCSession!
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.ticTacToeDelegate = self
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
    }
    
    @IBAction func advertise(_ sender: Any) {
        let nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "gt-tictactoe")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }
    
    @IBAction func dropAt(_ sender: UITapGestureRecognizer) {
        let finger = sender.location(in: boardView)
        let col: Int = Int(finger.x / (boardView.bounds.width/3))
        let row: Int = 2 - Int(finger.y / (boardView.bounds.height/3))
        ticTacToe.dropAt(col: col, row: row)
        print(ticTacToe)
        boardView.setNeedsDisplay()
    }
}

extension TicTacToeViewController: TicTacToeDelegate {
    func pieceAt(col: Int, row: Int) -> Piece? {
        return ticTacToe.pieceAt(col: col, row: row)
    }
}

extension TicTacToeViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}
