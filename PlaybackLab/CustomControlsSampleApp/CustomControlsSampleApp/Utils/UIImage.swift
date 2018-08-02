//
//  UIImage.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

extension UIImage {
  
  func tintWithColor(color: UIColor, alpha: CGFloat) -> UIImage {
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
    context.setFillColor(color.withAlphaComponent(alpha).cgColor)
    context.fill(CGRect(x:0,y: 0, width: 1, height: 1))
    let image = UIImage(cgImage: context.makeImage()!)
    return image
  }
  
  class func createThumbImage(size: CGFloat, color: UIColor) -> UIImage {
    let layerFrame = CGRect(x: 0, y: 0, width: size, height: size)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = CGPath(ellipseIn: layerFrame.insetBy(dx: 1, dy: 1), transform: nil)
    shapeLayer.fillColor = color.cgColor
    shapeLayer.strokeColor = color.withAlphaComponent(0.65).cgColor
    let layer = CALayer.init()
    layer.frame = layerFrame
    layer.addSublayer(shapeLayer)
    return self.imageFromLayer(layer: layer)
    
  }
  
  class func imageFromLayer(layer: CALayer) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, UIScreen.main.scale)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage!
  }

}

