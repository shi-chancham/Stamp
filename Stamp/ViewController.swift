//
//  ViewController.swift
//  Stamp
//
//  Created by 高橋詩穂 on 2015/12/05.
//  Copyright © 2015年 Shiho Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var imageNameArray: [String] = ["hige", "heart", "hoshi", "neko"]
    
    var imageIndex: Int = 0
    
    @IBOutlet var haikeiImageView: UIImageView!
    
    var imageView: UIImageView!
    
    var location = CGPoint()
    
    var imageArray:[UIImageView] = []
    
    var lastPoint: CGPoint!
    private var contextCache:[UIImage] = []
    
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
            lastPoint = touch!.locationInView(self.haikeiImageView)
            NSLog("began")
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if imageIndex != 0 && imageIndex < 5{
            let touch: UITouch = (touches.first)!
            location = touch.locationInView(self.view)
            imageView.center = CGPointMake(location.x, location.y)
            
        }else if imageIndex == 5 {
            let touch = touches.first
            let currentPoint: CGPoint! = touch!.locationInView(self.haikeiImageView)
            //let currentPoint: CGPoint! = touch!.locationInView(self.view)
            
            UIGraphicsBeginImageContext(self.haikeiImageView.bounds.size)
            let context: CGContextRef = UIGraphicsGetCurrentContext()!
            haikeiImageView.image?.drawInRect(haikeiImageView.bounds)
            
            CGContextSetLineWidth(context, 10.0)
            let color: CGColorRef = UIColor.blackColor().CGColor
            CGContextSetStrokeColorWithColor(context, color)
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextSetLineWidth(context, CGFloat(lineWidth))
            CGContextSetBlendMode(context, CGBlendMode.Normal)
            
            CGContextMoveToPoint(context, lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y)
            
            CGContextStrokePath(context)
            haikeiImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            lastPoint = currentPoint
            print(lastPoint)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if imageIndex != 0 && imageIndex < 5{
            imageView.center = CGPointMake(location.x, location.y)
        }else if imageIndex == 5 {
            UIGraphicsBeginImageContext(self.haikeiImageView.bounds.size)
            haikeiImageView.image?.drawInRect(haikeiImageView.bounds, blendMode: CGBlendMode.Normal, alpha: 1.0)
            UIGraphicsEndImageContext()
        }
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
        let rect: CGRect = CGRectMake(0, 30, 320, 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

