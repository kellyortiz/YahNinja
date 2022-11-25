//
//  GameViewController.swift
//  YahNinja
//
//  Created by Kelly Ortiz Figueiredo on 24/11/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad(){
            super.viewDidLoad()
            let scene = GameScene(size: CGSize(width: 2048, height: 1536))
            scene.scaleMode = .aspectFill
            
            let skView = view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            skView.presentScene(scene)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
