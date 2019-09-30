//
//  Hole.swift
//  ScaredyCat
//
//  Created by Victor Huang on 8/2/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Hole: SKNode {
    
    var catNode = SKSpriteNode()
    var catShowing = false
    var isHit = false
    
    func configure(at position: CGPoint) {
        
        self.position = position
        
        let hole = SKSpriteNode(imageNamed: "hole")
        hole.scale(to: CGSize(width: 170, height: 170))
        hole.zPosition = 0
        
        catNode = SKSpriteNode(imageNamed: "catOrange")
        catNode.position = CGPoint(x: 0, y: 0)
        catNode.name = "catOrange"
        catNode.zPosition = 1
        catNode.scale(to: CGSize(width: 80, height: 80))
        addChild(catNode)
        catNode.isHidden = true
        
        addChild(hole)
        
        
    }
    
    func show() {
        
        if catShowing { return }
        
        catNode.scale(to: CGSize(width: 80, height: 80))
        
        let random = RandomInt(min: 0, max: 2)
        
        switch random {
        case 0:
            catNode.texture = SKTexture(imageNamed: "catPurple")
            catNode.name = "catPurple"
        case 1:
            catNode.texture = SKTexture(imageNamed: "catBlue")
            catNode.name = "catBlue"
        case 2:
            catNode.texture = SKTexture(imageNamed: "catOrange")
            catNode.name = "catOrange"
        default:
            catNode.texture = SKTexture(imageNamed: "catOrange")
            catNode.name = "catOrange"
        }
        
        catNode.isHidden = false
        catShowing = true
        isHit = false
        
    }
    
    func hide() {
        
        if !catShowing { return }
        
        catNode.isHidden = true
        catShowing = false
        
    }
    
    func getHit() {
        
        catNode.scale(to: CGSize(width: 60, height: 60))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            self.hide()
        }

        isHit = true
        
    }
    
}
