//
//  PlayerVC.swift
//  TicTacToe
//
//  Created by Gali Srikanth on 05/08/18.
//  Copyright © 2018 Gs19. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    
    @IBOutlet weak var playerStatus: UILabel!
    @IBOutlet weak var viewMoves: UIView!
    
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var lblFinalResults: UILabel!
    
    var arrPlayer1Moves = [UIButton]()
    var arrPlayer2Moves = [UIButton]()
    var player1 = true
    var img:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding popup as the screen loads
        viewPopup.isHidden = true
        
        //Customizing moves as per the need
        for subview in viewMoves.subviews  {
            if subview is UIButton {
                if let btn:UIButton = subview as? UIButton {
                    btn.setTitle("", for: .normal)
                    btn.addTarget(self, action: #selector(btnMovesActn(_:)), for: .touchUpInside)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func btnMovesActn(_ sender: UIButton) {
        if !player1 {
            playerStatus.text = "Player1 is playing"
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            arrPlayer2Moves.append(sender)
        }
        else {
            playerStatus.text = "Player2 is playing"
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            arrPlayer1Moves.append(sender)
        }
        
        player1 = !player1
        sender.isEnabled = false
        
        if calculatePlayer1Results() {
            var player1Score:Int? = Int(lblPlayer1Score.text!)
            player1Score = player1Score! + 1
            lblPlayer1Score.text = "\(player1Score!)"
            
            img = captureScreen()
            
            viewPopup.isHidden = false
            lblFinalResults.text = "Congrats Player1 won the match"
        }
        
        if calculatePlayer2Results() {
            var player2Score:Int? = Int(lblPlayer2Score.text!)
            player2Score = player2Score! + 1
            lblPlayer2Score.text = "\(player2Score!)"
            
            img = captureScreen()
            
            viewPopup.isHidden = false
            lblFinalResults.text = "Congrats Player2 won the match"
        }
    }
    
    func calculatePlayer1Results() -> Bool {
        var arrXvalues = [Float]()
        var arrYvalues = [Float]()
        
        for btn in arrPlayer1Moves {
            arrXvalues.append(Float(btn.center.x))
            arrYvalues.append(Float(btn.center.y))
        }
        
        //Calculating y value
        var counts: [Float: Int] = [:]
        for item in arrYvalues {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        for (_, value) in counts {
            let val = value
            if val == 3 {
                playerStatus.text = "Player1 won the game"
                return true
            }
        }
        
        //Calculating x value
        var counts1: [Float: Int] = [:]
        for item in arrXvalues {
            counts1[item] = (counts1[item] ?? 0) + 1
        }
        
        for (_, value) in counts1 {
            let val = value
            if val == 3 {
                playerStatus.text = "Player1 won the game"
                return true
            }
        }
        
        //Calculating tag value
        var arrTagValues = [Int]()
        for btn in arrPlayer1Moves {
            arrTagValues.append(btn.tag)
        }
        
        let arrDiag1 = [0,4,8]
        var cnt1 = 0
        for tag in arrDiag1 {
            for btn in arrPlayer1Moves {
                if btn.tag == tag {
                    cnt1 += 1
                }
            }
        }
        
        if cnt1 == 3 {
            playerStatus.text = "Player1 won the game"
            return true
        }
        
        
        let arrDiag2 = [2,4,6]
        var cnt2 = 0
        for tag in arrDiag2 {
            for btn in arrPlayer1Moves {
                if btn.tag == tag {
                    cnt2 += 1
                }
            }
        }
        
        if cnt2 == 3 {
            playerStatus.text = "Player1 won the game"
            return true
        }
        
        return false
    }
    
    func calculatePlayer2Results() -> Bool {
        var arrXvalues = [Float]()
        var arrYvalues = [Float]()
        
        for btn in arrPlayer2Moves {
            arrXvalues.append(Float(btn.center.x))
            arrYvalues.append(Float(btn.center.y))
        }
        
        //Calculating y value
        var counts: [Float: Int] = [:]
        for item in arrYvalues {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        for (_, value) in counts {
            let val = value
            if val == 3 {
                playerStatus.text = "Player2 won the game"
                return true
            }
        }
        
        //Calculating x value
        var counts1: [Float: Int] = [:]
        for item in arrXvalues {
            counts1[item] = (counts1[item] ?? 0) + 1
        }
        
        for (_, value) in counts1 {
            let val = value
            if val == 3 {
                playerStatus.text = "Player2 won the game"
                return true
            }
        }
        
        //Calculating tag value
        var arrTagValues = [Int]()
        for btn in arrPlayer2Moves {
            arrTagValues.append(btn.tag)
        }
        
        let arrDiag1 = [0,4,8]
        var cnt1 = 0
        for tag in arrDiag1 {
            for btn in arrPlayer2Moves {
                if btn.tag == tag {
                    cnt1 += 1
                }
            }
        }
        
        if cnt1 == 3 {
            playerStatus.text = "Player2 won the game"
            return true
        }
        
        
        let arrDiag2 = [2,4,6]
        var cnt2 = 0
        for tag in arrDiag2 {
            for btn in arrPlayer2Moves {
                if btn.tag == tag {
                    cnt2 += 1
                }
            }
        }
        
        if cnt2 == 3 {
            playerStatus.text = "Player2 won the game"
            return true
        }
        
        return false
    }
    
    @IBAction func btnPlayAgainAction(_ sender: UIButton) {
        viewPopup.isHidden = true
        player1 = true
        lblFinalResults.text = ""
        
        playerStatus.text = "Player1 is playing"
        arrPlayer1Moves.removeAll()
        arrPlayer2Moves.removeAll()
        
        for subview in viewMoves.subviews  {
            if subview is UIButton {
                if let btn:UIButton = subview as? UIButton {
                    btn.setTitle("", for: .normal)
                    btn.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func btnShareScores(_ sender: UIButton) {
        let activityViewController = UIActivityViewController(activityItems:[img!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func captureScreen() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0);
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
