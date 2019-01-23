//
//  PointContainer.swift
//  Catch the Cat
//
//  Created by Steven Liu on 2019/1/10.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import SpriteKit
import UIKit

class PointContainer:SKNode{
    
    lazy var cat = Cat();
    let textPoint1 = SKTexture (imageNamed: "grey");
    let textPoint2 = SKTexture (imageNamed: "red");
    var arrPoint = [EkoPoint]();
    let start = 40;
    var currPos = 40;
    var isFind = false;
    var stepNum = 0;
    var arrNext = [Int]();
    
    //function to display the dots
    
    func dotInit(){
        for i in 0...80{
            let point = EkoPoint(texture: textPoint1);
            let row = Int (i/9);
            let col =  (i%9);
            
            
        
            var gap = 0;
            
            if Int(row % 2 ) == 1{
                gap = Int(textPoint1.size().width)/2 ;
            }else{
                
            }
            let width = Int(textPoint1.size().width);
            let x = col * (width+5) - (9*width)/2 + gap;
            let y = row * width - (9 * width)/2;
            point.position = CGPoint(x: x, y: y);
            
            if row == 0 || row == 8 || col == 0 || col == 8 {
                point.isEdge = true;
            }
            point.index = i;
            
            point.zPosition = 10;
            
            self.addChild(point);
            
            arrPoint.append(point);
        }
        onData();
        
        onCreateRed();
        
        cat.position = onGetPosition(index: start);
        cat.zPosition = 20;
        self.addChild(cat);
    }
    
    
    func onData(){
        for point in arrPoint{
            let row = Int(point.index / 9);
            
            //odd row
            if Int(row % 2) == 1{
                
                if point.index - 1 >= 0 && point.index - 1 <= 80{
                    point.arrPoint.append(point.index - 1);
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80{
                    point.arrPoint.append(point.index + 9);
                }
                if point.index + 10 >= 0 && point.index + 10 <= 80{
                    point.arrPoint.append(point.index + 10);
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80{
                    point.arrPoint.append(point.index + 1);
                }
                if point.index - 8 >= 0 && point.index - 8 <= 80{
                    point.arrPoint.append(point.index - 8);
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80{
                    point.arrPoint.append(point.index - 9);
                }
                
            
            }else{
                if point.index - 1 >= 0 && point.index - 1 <= 80{
                    point.arrPoint.append(point.index - 1);
                }
                if point.index + 8 >= 0 && point.index + 8 <= 80{
                    point.arrPoint.append(point.index + 8);
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80{
                    point.arrPoint.append(point.index + 9);
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80{
                    point.arrPoint.append(point.index + 1);
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80{
                    point.arrPoint.append(point.index - 9);
                }
                if point.index - 10 >= 0 && point.index - 10 <= 80{
                    point.arrPoint.append(point.index - 10);
                }
                
            }
        
    }
}
    
    //try to randomize location of red dots
    func onSetRed(index: Int){
        arrPoint[index].type = PointType.red;
        
    }
    
    func onCreateRed(){
        for i in 0...8 {
            let r1 = Int(arc4random() % 9) + i * 9;
            let r2 = Int(arc4random() % 9) + i * 9;
            
            if r1 != start{
                onSetRed(index: r1);
        }
            if r2 != start{
                onSetRed(index: r2);
            }
    }


}
    
    func onGetNextPoint(index: Int){
        onSetRed(index: index);
        for point in arrPoint[currPos].arrPoint{
            if arrPoint[point].isEdge && arrPoint[point].type == PointType.grey{
                cat.position = onGetPosition(index: arrPoint[point].index);
                let alert = UIAlertView(title: "", message: "You Lost!!", delegate: self, cancelButtonTitle: "Try Again!");
                alert.show();
                reset();
                
                return;
            }
        }
        onResetStep();
        
        let currPoint = arrPoint[currPos];
        currPoint.onSetLabel(i: "0");
        currPoint.step = 0;
        
        arrNext.append(currPos);
        onFind(arrPoint: arrNext);
        
        print("step: \(stepNum)");
        
        if !isFind {
            let alert = UIAlertView(title: "", message: "You Win!!", delegate: self, cancelButtonTitle: "Try Again!");
            alert.show();
            reset();
        }
    }
    
    
    
    
    
    
    //bredth traversal
    func onFind(arrPoint: [Int]){
        
        if !isFind {
            let arrNext = onGetNext(arrNext: arrPoint);
            if arrNext.count != 0{
                onFind(arrPoint: arrNext);
            }
        }
    }
    
    func onGetNext(arrNext: [Int]) -> [Int]{
        
        let step = arrPoint[arrNext[0]].step + 1;
        
        var tempPoints = [Int]();
        
        for nextP in arrNext {
            
            if isFind{
                break;
            }
            
            for p in arrPoint[nextP].arrPoint{
                self.stepNum += 1;
                
                if arrPoint[p].isEdge && arrPoint[p].type == PointType.grey{
                    arrPoint[p].onSetLabel(i: "end");
                    isFind = true;
                    
                    onGetPre(point: arrPoint[p]);
                    break;
                }
                if( arrPoint[p].type == PointType.grey ) && ( arrPoint[p].step > arrPoint[nextP].step){
                    arrPoint[p].step = step;
                    arrPoint[p].onSetLabel(i: "\(step)");
                    arrPoint[p].prePointIndex = arrPoint[nextP].index;
                    
                    if arrPoint[p].index != arrPoint[nextP].prePointIndex {
                        tempPoints.append(p);
                    }
                    
                }
            }
        }
        return tempPoints
    }
    
    
    func onGetPre( point: EkoPoint ){
        
        var p2 = point.arrPoint[0];
        for p in point.arrPoint{
            if arrPoint[p].step < arrPoint[p2].step{
                p2 = p;
            }
        }
        if arrPoint[p2].step == 0{
            point.onSetLabel(i: "next");
            
            cat.position = onGetPosition(index: point.index);
            
            self.currPos = point.index;
        }else{
            onGetPre(point: arrPoint[p2]);
        }
    }
    
    func onGetPosition(index: Int) -> CGPoint{
        return CGPoint(x: arrPoint[index].position.x, y: arrPoint[index].position.y);
        
    }
    
    func onResetStep(){
        arrNext = [Int]();
        isFind = false;
        stepNum = 0;
        
        for p in arrPoint{
            p.step = 99;
            p.prePointIndex = -1;
            p.onSetLabel(i: "");
        }
    }
    
     func reset(){
        
        cat.position = onGetPosition(index: start);
        
        for p in arrPoint{
            p.type = PointType.grey;
            p.texture = textPoint1;
        }
        
        currPos = start;
        
        onCreateRed();
        onResetStep();
        
    }
    
}
