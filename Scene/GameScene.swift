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
    var cameraNode = SKCameraNode()
    var obstacles: [SKSpriteNode] = []
    var cameraMovePointPerSecond: CGFloat = 450.0
    
    var lastUpdateTime: TimeInterval = 0.0
    var dt: TimeInterval = 0.0
    
    var playableRect: CGRect {
        let ratio: CGFloat
        switch UIScreen.main.nativeBounds.height {
        case 2688, 1792, 2436:
            ratio = 2.16
        default:
            ratio = 16/9
        }
        let playableHeight = size.width / ratio
        let playableMargin = (size.height - playableHeight) / 2.0
        
        return CGRect(x: 0.0, y: playableMargin, width: size.width, height: playableHeight)
    }
    
    var cameraRect: CGRect {
        let width = playableRect.width
        let height = playableRect.height
        let x = cameraNode.position.x - size.width/2.0 + (size.width - width)/2.0
        let y = cameraNode.position.y - size.height/2.0 + (size.height - height)/2.0
        
        return CGRect(x: x, y:y, width: width, height: height)
    }
    
    //MARK: - Systems
    override func didMove(to view: SKView) {
        setUpNodes()
    }
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        moveCamera()
        movePlayer()
    }
}

// MARK: - Configurations

extension GameScene{
    func setUpNodes(){
        createBG()
        createGround()
        createPlayer()
        setupCamera()
        setupObstacles()
    }
    func createBG(){
        for i in 0...2{
            let bg = SKSpriteNode(imageNamed: "background")
            bg.anchorPoint = .zero
            bg.position = CGPoint(x: CGFloat(i)*bg.frame.width, y: 0.0)
            bg.zPosition = -1.0
            addChild(bg)
        }
    }
    func createGround(){
        for i in 0...2{
            ground = SKSpriteNode(imageNamed: "ground")
            ground.name = "Ground"
            ground.anchorPoint = .zero
            ground.zPosition = 1.0
            ground.position = CGPoint(x: CGFloat(i)*ground.frame.width, y:1.0)
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
    func setupCamera() {
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    func moveCamera(){
        let amountToMove = CGPoint(x: cameraMovePointPerSecond *
            CGFloat (dt), y: 0.0)
        cameraNode.position += amountToMove
        
        // Background
        enumerateChildNodes(withName: "BG"){ (node, _) in
            let node = node as! SKSpriteNode
            
            if node.position.x + node.frame.width < self.cameraRect.origin.x{
                node.position = CGPoint(x: node.position.x + node.frame.width*2.0,
                                        y: node.position.y)
            }
        }
        // Ground
        enumerateChildNodes(withName: "Ground"){ (node, _) in
            let node = node as! SKSpriteNode
            
            if node.position.x + node.frame.width < self.cameraRect.origin.x{
                node.position = CGPoint(x: node.position.x + node.frame.width*2.0,
                                        y: node.position.y)
            }
        }
        
    }
    func movePlayer(){
        let amountToMove = cameraMovePointPerSecond * CGFloat(dt)
        let rotate = CGFloat(1).degreesToRadians() * amountToMove/2.5
        player.zRotation -= rotate
        player.position.x += amountToMove
    }
    
    func setupObstacles(){
        for i in 1...3 {
            let sprite = SKSpriteNode(imageNamed: "block-\(i)")
            sprite.name = "Block"
            obstacles.append(sprite)
        }
        for i in 1...2 {
            let sprite = SKSpriteNode(imageNamed: "obstacle-\(i)")
            sprite.name = "Obstacle"
            obstacles.append(sprite)
        }
        
        let index = Int(arc4random_uniform(UInt32(obstacles.count-1)))
        let sprite = obstacles[index].copy() as! SKSpriteNode
        sprite.zPosition = 5.0
        sprite.position = CGPoint(x: cameraRect.maxX +
                                  sprite.frame.width/2.0,
                                  y: ground.frame.height/2.0)
        addChild(sprite)
    }
}

