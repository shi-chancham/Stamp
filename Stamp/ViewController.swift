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
    
    @IBOutlet var photoImageView: UIImageView!
    
    //subview出てるか
    var isSubViewAppear = false
    
    var lineColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    let subView = SubView()

    
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
        
        subView.redButton.addTarget(self, action: "changeColor1:", forControlEvents: .TouchUpInside)
        
        subView.blueButton.addTarget(self, action: "changeColor2:", forControlEvents: .TouchUpInside)

        subView.greenButton.addTarget(self, action: "changeColor3:", forControlEvents: .TouchUpInside)
        
        subView.yellowButton.addTarget(self, action: "changeColor4:", forControlEvents: .TouchUpInside)

        subView.orangeButton.addTarget(self, action: "changeColor5:", forControlEvents: .TouchUpInside)
        
        subView.purpleButton.addTarget(self, action: "changeColor6:", forControlEvents: .TouchUpInside)
        
        subView.blackButton.addTarget(self, action: "changeColor7:", forControlEvents: .TouchUpInside)

        if isSubViewAppear == false {
            //viewに追加
            self.view.addSubview(subView)
            isSubViewAppear = true
        }else {
            
            //消す
            subView.removeFromSuperview()
            isSubViewAppear = false
        }
    }
    
    func changeColor1(sender: UIButton) {
        lineColor = UIColor.redColor()
    }
    
    func changeColor2(sender: UIButton) {
        lineColor = UIColor.blueColor()
    }
    
    func changeColor3(sender: UIButton) {
        lineColor = UIColor.greenColor()
    }
    
    func changeColor4(sender: UIButton) {
        lineColor = UIColor.yellowColor()
    }
    
    func changeColor5(sender: UIButton) {
        lineColor = UIColor.orangeColor()
    }
    
    func changeColor6(sender: UIButton) {
        lineColor = UIColor.purpleColor()
    }
    
    func changeColor7(sender: UIButton) {
        lineColor = UIColor.blackColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = (touches.first)!
        if touch.locationInView(self.view).y < haikeiImageView.frame.height {
            //1~4はスタンプ
            if imageIndex != 0 && imageIndex < 5{
                print(touch.locationInView(self.view).y)
                print(haikeiImageView.frame.height)
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
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = (touches.first)!
        if touch.locationInView(self.view).y < haikeiImageView.frame.height {
            if imageIndex != 0 && imageIndex < 5{
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
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if touch!.locationInView(self.view).y < haikeiImageView.frame.height {
            if imageIndex != 0 && imageIndex < 5{
                
                imageView.center = CGPointMake(location.x, location.y)
            }else if imageIndex == 5 {
                if bezierPath == nil {
                    return
                }
                let currentPoint:CGPoint = touch!.locationInView(haikeiImageView)
                bezierPath.addLineToPoint(currentPoint)
                drawLine(bezierPath)
                lastDrawImage = haikeiImageView.image
                //            UIGraphicsBeginImageContext(self.haikeiImageView.bounds.size)
                //            haikeiImageView.image?.drawInRect(haikeiImageView.bounds, blendMode: CGBlendMode.Normal, alpha: 1.0)
                //            UIGraphicsEndImageContext()
            }
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
        //色
        lineColor.setStroke()
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
        
        photoImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func save() {
        let sheet: UIActionSheet = UIActionSheet()
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
            
            let alert = UIAlertController(title: "保存",
                message: "カメラロールに保存しました",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: {action in
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                )
            )
            sheet.removeFromSuperview()
            presentViewController(alert, animated: true, completion: nil)
            
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
            
            //投稿終了後に呼ばれる
            myComposeView.completionHandler = {
                (result:SLComposeViewControllerResult) -> () in
                switch (result) {
                case SLComposeViewControllerResult.Done:
                    print("hoge")
                    
                    NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: "showAlert:", userInfo: nil, repeats: false)
                    
                    
                case SLComposeViewControllerResult.Cancelled:
                    break
                }
            }
            
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
            
            let alert = UIAlertController(title: "保存",
                message: "シェアしました",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: {action in
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                )
            )
            //アラート表示
            sheet.removeFromSuperview()
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(timer : NSTimer) {
        let alert = UIAlertController(title: "保存",
            message: "シェアしました",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: {action in
                    self.navigationController?.popViewControllerAnimated(true)
                }
            )
        )
        //アラート表示
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}




