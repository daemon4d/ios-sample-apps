//
//  CustomControlsViewController.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class CustomControlsViewController: OOControlsViewController {
  
  private var customControls: CustomControls {
    get{
      return controls as! CustomControls
    }
  }
  
  override func viewDidLoad() {
    if player == nil {
      return
    }
    controls = CustomControls(frame: view.bounds)
    
    super.viewDidLoad()
  }

}
