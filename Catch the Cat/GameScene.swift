//
//  GameScene.swift
//  Catch the Cat
//
//  Created by Steven Liu on 2019/1/10.
//  Copyright © 2019 Steven Liu. All rights reserved.
//
import SpriteKit
let pointContainer = PointContainer();

class GameScene: SKScene{
    override func didMove(to view: SKView) {
        var bg = SKSpriteNode(imageNamed: "bg");
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        self.addChild(bg);
       
        pointContainer.position = CGPoint(x: self.frame.midX - 10.0, y: self.frame.midY - 150.0);
        
        self.addChild(pointContainer);
        pointContainer.dotInit();
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let location = touch.location(in: self);
            
            let arrObject = self.nodes(at: location);
            
            for p in arrObject{
                let point = p as? EkoPoint;
                
                if point != nil && point!.type != PointType.red {
                    pointContainer.onGetNextPoint(index: point!.index);
                }
            }
        }
 
    }
 
    
}

//respond to user tapping





