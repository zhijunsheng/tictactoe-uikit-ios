//
//  ViewController.swift
//  TicTacToe
//
//  Created by Golden Thumb on 2020-12-20.
//

import UIKit
import MultipeerConnectivity

class TicTacToeViewController: UIViewController {
    let serviceType = "gt-tictactoe"
    var ticTacToe = TicTacToe()
    
    private var peerID: MCPeerID!
    private var session: MCSession!
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.ticTacToeDelegate = self
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
    }
    
    @IBAction func advertise(_ sender: Any) {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
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
        
        let move = "\(col),\(row)" // 0,0
        if let data = move.data(using: .utf8) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
    
    @IBAction func invite(_ sender: Any) {
        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.delegate = self
        present(browser, animated: true, completion: nil)
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

extension TicTacToeViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
}

extension TicTacToeViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let moveStr = String(data: data, encoding: .utf8) {
            let moveArr = moveStr.split(separator: ",")
            if let col = Int(moveArr[0]), let row = Int(moveArr[1]) {
                DispatchQueue.main.async {
                    self.ticTacToe.dropAt(col: col, row: row)
                    self.boardView.setNeedsDisplay()
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}
