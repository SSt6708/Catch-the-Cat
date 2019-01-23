//
//  Cat.swift
//  Catch the Cat
//
//  Created by Steven Liu on 2019/1/13.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import SpriteKit


class Cat:SKSpriteNode{
    
    let dbAtlas = SKTextureAtlas(named: "db.atlas");
    
    var dbFrames = [SKTexture]()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = dbAtlas.textureNamed("db_01");
        
        let size = texture.size();
        
        super.init(texture: texture, color: SKColor.white, size: size);
        
        let texture1 = dbAtlas.textureNamed("db_01");
        let texture2 = dbAtlas.textureNamed("db_02");
        let texture3 = dbAtlas.textureNamed("db_03");
        let texture4 = dbAtlas.textureNamed("db_04");
        
        dbFrames.append(texture1);
        dbFrames.append(texture2);
        dbFrames.append(texture3);
        dbFrames.append(texture4);
        
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.2);
        db();
            
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func db(){
        self.run(SKAction.repeatForever(SKAction.animate(with: dbFrames, timePerFrame: 0.2)));
    }
}
