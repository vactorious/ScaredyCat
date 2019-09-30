//
//  GameScene.swift
//  ScaredyCat
//
//  Created by Victor Huang on 8/2/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var scoreLabel : SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var highScore = 0
    var time = 0.28
    var holes = [Hole]()
    var numShowing = 0
    var masterCat : SKSpriteNode!
    var gameOn = false
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        
        masterCat = SKSpriteNode(imageNamed: "catOrange")
        masterCat.name = "catOrange"
        masterCat.position = CGPoint(x: 0, y: self.frame.height / 2.5)
        masterCat.xScale = 0.7
        masterCat.yScale = 0.7
        addChild(masterCat)
        
        scoreLabel = SKLabelNode(fontNamed: "Fipps-Regular")
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: -self.frame.width / 3.3 , y: self.frame.height / 2.75)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = 72
        scoreLabel.fontColor = .black
        addChild(scoreLabel)
        
        setup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.gameOn = true
            self.startGame()
            self.startCat()
        }
        
    }
    
    func setup() {
        
        let yFactor = self.frame.height / 6
        
        for i in -2 ..< 3 { makeHole(at: CGPoint(x: CGFloat(i * 125), y: yFactor - 75)) }
        for i in -2 ..< 3 { makeHole(at: CGPoint(x: CGFloat(i * 125), y: yFactor * 2 - 75)) }
        for i in -2 ..< 3 { makeHole(at: CGPoint(x: CGFloat(i * 125), y: -75)) }
        for i in -2 ..< 3 { makeHole(at: CGPoint(x: CGFloat(i * 125), y: -yFactor - 75)) }
        for i in -2 ..< 3 { makeHole(at: CGPoint(x: CGFloat(i * 125), y: -yFactor * 2 - 75)) }
        
    }
    
    func startCat() {
        
        let interval = 1.1
        let minInt = interval / 1.1
        let maxInt = interval * 1.1
        
        let actualInt = RandomDouble(min: minInt, max: maxInt)
        
        self.changeCat()
        
        if self.gameOn == false { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + actualInt) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.startCat()
                
            }
            
        
        
    }
    
    func changeCat() {
        
        let changer = RandomInt(min: 0, max: 2)
        
        switch changer {
        case 0:
            masterCat.texture = SKTexture(imageNamed: "catPurple")
            masterCat.name = "catPurple"
        case 1:
            masterCat.texture = SKTexture(imageNamed: "catBlue")
            masterCat.name = "catBlue"
        case 2:
            masterCat.texture = SKTexture(imageNamed: "catOrange")
            masterCat.name = "catOrange"
        default:
            masterCat.texture = SKTexture(imageNamed: "catOrange")
            masterCat.name = "catOrange"
        }
        
    }
    
    func startGame() {
        
        var num = 0
        
        for hole in holes {
            if hole.catShowing == true {
                num += 1
            }
        }
        
        if num >= 17 {
            gameOver()
            return
        }
        
        time *= 0.993
        
        holes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: holes) as! [Hole]
        holes[0].show()
        numShowing += 1
        
        let minDelay = time / 2.0
        let maxDelay = time * 2
        let delay = RandomDouble(min: minDelay, max: maxDelay)
        
        if gameOn == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
                self.startGame()
            }
        }
        
    }
    
    func gameOver() {
        
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "highScore") != nil {
            highScore = userDefaults.value(forKey: "highScore") as! Int
        }
        
        if score > highScore {
            highScore = score
            userDefaults.setValue(highScore, forKey: "highScore")
            userDefaults.synchronize()
        }
        
        let scene = SKScene(fileNamed: "GameOver") as! GameOver
        
        scene.setScore(score: score)
        scene.scaleMode = .aspectFill
        let transition = SKTransition.fade(withDuration: 0.5)
        
        self.gameOn = false

        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func makeHole(at position: CGPoint) {
        
        let hole = Hole()
        hole.configure(at: position)
        holes.append(hole)
        addChild(hole)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            
            let location = touch.location(in: self)
            let touchedNodes = nodes(at: location)
            
            for node in touchedNodes {
                
                if node.name == "catOrange" || node.name == "catBlue" || node.name == "catPurple" {
                    
                    if node.name == masterCat.name {
                        let touchedHole = node.parent! as! Hole
                        if !touchedHole.catShowing { continue }
                        if touchedHole.isHit { continue }
                        
                        touchedHole.getHit()
                        
                        score += 1
                        numShowing -= 1
                    }
                        
                    else {
                        gameOver()
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
