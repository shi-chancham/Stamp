//
//  SubView.swift
//  Stamp
//
//  Created by 高橋詩穂 on 2016/02/20.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class SubView: UIView {
    
    
    init() {
        super.init(frame: CGRectZero)
        
        self.frame = CGRect(x: 0, y: 485, width: 375, height: 70)
        self.backgroundColor = UIColor.whiteColor()
        
        
        
        // サイズを設定する.
        let redButton = UIButton(frame: CGRectMake(30,30,30,30))
        
        // 背景色を設定する.
        redButton.backgroundColor = UIColor.redColor()
        
        // 枠を丸くする.
        redButton.layer.masksToBounds = true
        
        // ボタンの位置を指定する.
        redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(redButton)

    }

    /*func redButton = UIButton() {
        
        // サイズを設定する.
        redButton.frame = CGRectMake(30,30,30,30)
        
        // 背景色を設定する.
        redButton.backgroundColor = UIColor.redColor()
        
        // 枠を丸くする.
        redButton.layer.masksToBounds = true
        
        // ボタンの位置を指定する.
        redButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.view.addSubview(redButton)
    }*/
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

