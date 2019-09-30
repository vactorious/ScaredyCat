//
//  StartScene.swift
//  ScaredyCat
//
//  Created by Victor Huang on 8/5/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        
        let title = SKSpriteNode(imageNamed: "title")
        title.position = CGPoint(x: 0, y: 0)
        addChild(title)
        
        let startMessage = SKLabelNode(fontNamed: "Fipps-Regular")
        startMessage.text = "Tap Anywhere to Start"
        startMessage.fontColor = .black
        startMessage.fontSize = 30
        startMessage.position = CGPoint(x: 0, y: -self.frame.height / 2 + 30)
        addChild(startMessage)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeAllChildren()
        
        if let scene = SKScene(fileNamed: "GameScene") {
            
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene)
            
        }
        
    }
    
}
