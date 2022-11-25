//
//  GameScene.swift
//  YahNinja
//
//  Created by Kelly Ortiz Figueiredo on 24/11/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: - Properties
    
    var ground: SKSpriteNode!
    var player: SKSpriteNode!
    
    //MARK: - Systems
    override func didMove(to view: SKView) {
         setUpNodes()
    }
    }

// MARK: - Configurations

extension GameScene{
    func setUpNodes(){
        createBG()
        createGround()
        createPlayer()
    }
    func createBG(){
        let bg = SKSpriteNode(imageNamed: "background")
        bg.anchorPoint = .zero
        bg.position = .zero
        bg.zPosition = -1.0
        addChild(bg)
    }
    func createGround(){
        for i in 0...2{
            ground = SKSpriteNode(imageNamed: "ground")
            ground.name = "Ground"
            ground.anchorPoint = .zero
            ground.zPosition = 1.0
            ground.position = CGPoint(x: CGFloat(i)*ground.frame.width, y:0.0)
            addChild(ground)
        }
    }
        func createPlayer(){
            player = SKSpriteNode(imageNamed: "ninja")
            player.name = "Player"
            player.zPosition = 5.0
            player.position = CGPoint(x: frame.width/2.0 - 100.0,
                                      y: ground.frame.height +
                                      player.frame.height/2.0)
            addChild(player)
        }
}

