//
//  EkoPoint.swift
//  Catch the Cat
//
//  Created by Steven Liu on 2019/1/10.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import SpriteKit
enum PointType:Int {
    case grey = 0, red;
}
class EkoPoint:SKSpriteNode{
    
    var prePointIndex = -1;
    var arrPoint = [Int]();
    var step = 99;
    var index = 0;
    var type  = PointType.grey;
    var isEdge = false;
    var label: SKLabelNode? ;
    
    func onSetLabel(i: String){
        if label == nil {
            label = SKLabelNode(fontNamed: "Chalkduster");
            label!.fontSize = 0;
            label!.position = CGPoint(x: -1.0, y: 10.0);
            label!.isUserInteractionEnabled = false;
            //self.addChild(label!);
        }
        label!.text = i;
    }
}
