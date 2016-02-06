//
//  ViewController.swift
//  Stamp
//
//  Created by 高橋詩穂 on 2015/12/05.
//  Copyright © 2015年 Shiho Takahashi. All rights reserved.
//

import UIKit

import AssetsLibrary

import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIActionSheetDelegate {
    
    var imageNameArray: [String] = ["hige", "heart", "star", "neko"]
    
    var imageIndex: Int = 0
    
    @IBOutlet var haikeiImageView: UIImageView!
    
    var imageView: UIImageView!
    
    var location = CGPoint()
    
    var imageArray:[UIImageView] = []
    
    var lastPoint: CGPoint!
    private var contextCache:[UIImage] = []
    
    var lastDrawImage: UIImage!
    var bezierPath: UIBezierPath!
    
    //lineWidth
    var lineSize : [Float] = [15.0, 10.0, 5.0]
    var lineWidth : Float = 10.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    @IBAction func selectedFifth(){
        imageIndex = 5
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //1~4はスタンプ
        if imageIndex != 0 && imageIndex < 5{
            let touch: UITouch = (touches.first)!
            location = touch.locationInView(self.view)
            
            imageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
            
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
            
            imageView.center = CGPointMake(location.x, location.y)
            
            self.view.addSubview(imageView)
            imageArray.append(imageView)
            
            //5はペン
        } else if imageIndex == 5 {
            let touch = touches.first
            let currentPoint:CGPoint = touch!.locationInView(haikeiImageView)
            bezierPath = UIBezierPath()
            bezierPath.lineWidth = 1.0
            bezierPath.moveToPoint(currentPoint)
            //lastPoint = touch!.locationInView(self.haikeiImageView)
            //NSLog("began")
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if imageIndex != 0 && imageIndex < 5{
            let touch: UITouch = (touches.first)!
            location = touch.locationInView(self.view)
            imageView.center = CGPointMake(location.x, location.y)
            
        }else if imageIndex == 5 {
            if bezierPath == nil {
                return
            }
            let touch = touches.first
            let currentPoint:CGPoint = touch!.locationInView(haikeiImageView)
            bezierPath.addLineToPoint(currentPoint)
            drawLine(bezierPath)
         }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if imageIndex != 0 && imageIndex < 5{
            imageView.center = CGPointMake(location.x, location.y)
        }else if imageIndex == 5 {
            if bezierPath == nil {
                return
            }
            let touch = touches.first
            let currentPoint:CGPoint = touch!.locationInView(haikeiImageView)
            bezierPath.addLineToPoint(currentPoint)
            drawLine(bezierPath)
            lastDrawImage = haikeiImageView.image
//            UIGraphicsBeginImageContext(self.haikeiImageView.bounds.size)
//            haikeiImageView.image?.drawInRect(haikeiImageView.bounds, blendMode: CGBlendMode.Normal, alpha: 1.0)
//            UIGraphicsEndImageContext()
        }
    }
    
    @IBAction func clear() {
        lastDrawImage = nil
        haikeiImageView.image = nil
    }
    
    func drawLine(path:UIBezierPath) {
        UIGraphicsBeginImageContext(haikeiImageView.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.drawAtPoint(CGPointZero)
        }
        let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        blackColor.setStroke()
        path.stroke()
        haikeiImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func back() {
        //self.imageView.removeFromSuperview()
        
        if imageArray.count != 0{
            imageArray[imageArray.count-1].removeFromSuperview()
            imageArray.removeLast()
        }
    }
    
    @IBAction func selectBackground() {
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        haikeiImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func save() {
        var sheet: UIActionSheet = UIActionSheet()
        let title: String = "Please choose a plan"
        sheet.title  = title
        sheet.delegate = self
        sheet.addButtonWithTitle("Cancel")
        sheet.addButtonWithTitle("カメラロールに保存")
        sheet.addButtonWithTitle("Twitterでツイート")
        sheet.addButtonWithTitle("FaceBookに投稿")
        
        sheet.cancelButtonIndex = 0
        sheet.showInView(self.view)
    }
    
    func actionSheet(sheet: UIActionSheet,clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            //            let rect: CGRect = haikeiImageView.frame
            //            UIGraphicsBeginImageContext(rect.size)
            //            self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            //            let capture = UIGraphicsGetImageFromCurrentImageContext()
            //            UIGraphicsEndImageContext()
            //
            //            UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil)
            
            UIGraphicsBeginImageContextWithOptions(haikeiImageView.bounds.size, true, 1.0)
            // 描画
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
            // 描画が行われたスクリーンショットの取得
            let screenShot = UIGraphicsGetImageFromCurrentImageContext()
            // スクリーンショットの取得終了
            UIGraphicsEndImageContext()
            //hozonn
            UIImageWriteToSavedPhotosAlbum(screenShot, self, nil, nil)
            
        }else if buttonIndex == 2 {
            UIGraphicsBeginImageContextWithOptions(haikeiImageView.bounds.size, true, 1.0)
            // 描画
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
            // 描画が行われたスクリーンショットの取得
            let screenShot = UIGraphicsGetImageFromCurrentImageContext()
            // スクリーンショットの取得終了
            UIGraphicsEndImageContext()
            
            //ツイート
            let myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            // 投稿するテキストを指定.
            myComposeView.setInitialText("写真にスタンプを押したよ！")
            
            // 投稿する画像を指定.
            myComposeView.addImage(screenShot)
            
            // myComposeViewの画面遷移.
            self.presentViewController(myComposeView, animated: true, completion: nil)
        }else if buttonIndex == 3 {
            UIGraphicsBeginImageContextWithOptions(haikeiImageView.bounds.size, true, 1.0)
            // 描画
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
            // 描画が行われたスクリーンショットの取得
            let screenShot = UIGraphicsGetImageFromCurrentImageContext()
            // スクリーンショットの取得終了
            UIGraphicsEndImageContext()
            
            //ツイート
            let myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            // 投稿するテキストを指定.
            myComposeView.setInitialText("写真にスタンプを押したよ！")
            
            // 投稿する画像を指定.
            myComposeView.addImage(screenShot)
            
            // myComposeViewの画面遷移.
            self.presentViewController(myComposeView, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




