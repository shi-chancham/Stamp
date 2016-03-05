//
//  SubView.swift
//  Stamp
//
//  Created by 高橋詩穂 on 2016/02/20.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class SubView: UIView {
    
    var redButton = UIButton()
    
    var blueButton = UIButton()
    
    var greenButton = UIButton()
    
    var yellowButton = UIButton()
    
    var orangeButton = UIButton()
    
    var purpleButton = UIButton()
    
    var blackButton = UIButton()
    
    init() {
        super.init(frame: CGRectZero)
        
        self.frame = CGRect(x: 0, y: 485, width: 375, height: 70)
        self.backgroundColor = UIColor.whiteColor()
        
        // サイズを設定する.
        redButton = UIButton(frame: CGRectMake(25,22.5,30,30))
        
        // 背景色を設定する.
        redButton.backgroundColor = UIColor.redColor()
        
        // 枠を丸くする.
        redButton.layer.masksToBounds = true
        redButton.layer.cornerRadius = redButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(redButton)
        
        // サイズを設定する.
        blueButton = UIButton(frame: CGRectMake(75,22.5,30,30))
        
        // 背景色を設定する.
        blueButton.backgroundColor = UIColor.blueColor()
        
        // 枠を丸くする.
        blueButton.layer.masksToBounds = true
        blueButton.layer.cornerRadius = blueButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(blueButton)
        
        // サイズを設定する.
        greenButton = UIButton(frame: CGRectMake(125,22.5,30,30))
        
        // 背景色を設定する.
        greenButton.backgroundColor = UIColor.greenColor()
        
        // 枠を丸くする.
        greenButton.layer.masksToBounds = true
        greenButton.layer.cornerRadius = greenButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(greenButton)
        
        // サイズを設定する.
        yellowButton = UIButton(frame: CGRectMake(175,22.5,30,30))
        
        // 背景色を設定する.
        yellowButton.backgroundColor = UIColor.yellowColor()
        
        // 枠を丸くする.
        yellowButton.layer.masksToBounds = true
        yellowButton.layer.cornerRadius = yellowButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(yellowButton)
        
        // サイズを設定する.
        orangeButton = UIButton(frame: CGRectMake(225,22.5,30,30))
        
        // 背景色を設定する.
        orangeButton.backgroundColor = UIColor.orangeColor()
        
        // 枠を丸くする.
        orangeButton.layer.masksToBounds = true
        orangeButton.layer.cornerRadius = orangeButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(orangeButton)
        
        // サイズを設定する.
        purpleButton = UIButton(frame: CGRectMake(275,22.5,30,30))
        
        // 背景色を設定する.
        purpleButton.backgroundColor = UIColor.purpleColor()
        
        // 枠を丸くする.
        purpleButton.layer.masksToBounds = true
        purpleButton.layer.cornerRadius = purpleButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(purpleButton)
        
        // サイズを設定する.
        blackButton = UIButton(frame: CGRectMake(325,22.5,30,30))
        
        // 背景色を設定する.
        blackButton.backgroundColor = UIColor.blackColor()
        
        // 枠を丸くする.
        blackButton.layer.masksToBounds = true
        blackButton.layer.cornerRadius = blackButton.frame.height/2
        
        // ボタンの位置を指定する.
        //redButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
        
        // ボタンをViewに追加する.
        self.addSubview(blackButton)

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

