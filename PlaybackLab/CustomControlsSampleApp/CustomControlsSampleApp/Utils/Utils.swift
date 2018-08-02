//
//  Utils.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

struct Utils {
  static func stringFromTimeInterval(interval: Float64) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour]
    formatter.zeroFormattingBehavior = .pad
    let output = formatter.string(from: TimeInterval(interval))!
    //return Int(interval) < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    
    return Int(interval) < 3600 ? String(output[output.range(of: ":")!.upperBound...]) : output
  }
}

struct AppUtility {
  static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    if let delegate = UIApplication.shared.delegate as? AppDelegate {
      delegate.orientationLock = orientation
    }
  }
  
  /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
  static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
    self.lockOrientation(orientation)
    UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
  }
  
}

struct DeviceType {
  static var isIPhoneX: Bool {
    if #available(iOS 11, *) {
      if let insets = UIApplication.shared.delegate?.window??.safeAreaInsets {
        if insets.top > 0 {
          return true
        }
      }
    }
    return false
  }
}
