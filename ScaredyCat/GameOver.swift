//
//  GameOver.swift
//  ScaredyCat
//
//  Created by Victor Huang on 8/5/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    var endScore = 0
    var highScore = 0
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 0, y: 300)
        gameOver.zPosition = 1
        
        addChild(gameOver)
        
        let deadCat = SKSpriteNode(imageNamed: "deadcat")
        deadCat.position = CGPoint(x: 0, y: 50)
        deadCat.zPosition = 1
        addChild(deadCat)
        
        let retryButton = SKSpriteNode(imageNamed: "replay")
        retryButton.position = CGPoint(x: 0, y: -400)
        retryButton.zPosition = 1
        retryButton.xScale = 0.5
        retryButton.yScale = 0.5
        retryButton.name = "retry"
        
        addChild(retryButton)
        
        let scoreLabel = SKLabelNode(fontNamed: "Fipps-Regular")
        scoreLabel.text = "Score: \(endScore)"
        scoreLabel.position = CGPoint(x: 0, y: -175)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = .black
        scoreLabel.zPosition = 1
        
        addChild(scoreLabel)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "highScore") != nil {
            highScore = userDefaults.value(forKey: "highScore") as! Int
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Fipps-Regular")
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.position = CGPoint(x: 0, y: -275)
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.fontSize = 38
        highScoreLabel.fontColor = .black
        highScoreLabel.zPosition = 1
        
        addChild(highScoreLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let touchedNodes = nodes(at: location)
            
            for node in touchedNodes {
                
                if node.name == "retry" {
                    
                    if let scene = SKScene(fileNamed: "GameScene") {
                        scene.scaleMode = .aspectFill
                        self.view?.presentScene(scene)
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    func setScore(score: Int) {
        
        self.endScore = score
        
    }
    
}
