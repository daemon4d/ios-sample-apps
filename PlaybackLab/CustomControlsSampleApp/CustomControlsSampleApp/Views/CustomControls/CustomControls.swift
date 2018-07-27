//
//  CustomControls.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class CustomControls: UIView {

  private(set) var isFullscreen = false
  private(set) var isAirplay = false
  private(set) var isCast = false
  
  // Font
  private let ooyalaFont = UIFont(name: "ooyala-slick-type", size: 15)!
  private let robotoRegularFont = UIFont(name: "Roboto-Regular", size: 12)!
  
  // Spaces
  private let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  private let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
  
  private var toolbarTop: UIToolbar!
  private var toolbarMid: UIToolbar!
  private var toolbarBottom: UIToolbar!
  
  private(set) var title: UILabel!
  
  private(set) var playPause: UIButton!
  private var playPauseBtn: UIBarButtonItem!
  
  private(set) var fullscreen: UIButton!
  private var fullscreenBtn: UIBarButtonItem!
  
  private(set) var closedCaptions: UIButton!
  private var closedCaptionsBtn: UIBarButtonItem!
  
  override init(frame: CGRect){
    super.init(frame: frame)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    initButtons()
    syncUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Init
  private func initButtons() {
    fixedSpace.width = 20
    
    toolbarTop = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
    toolbarTop.autoresizingMask = .flexibleWidth
    toolbarTop.clipsToBounds = true
    
    toolbarMid = UIToolbar(frame: CGRect(x: 0, y: frame.height / 2 - 20, width: frame.width, height: 40))
    toolbarMid.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
    toolbarMid.clipsToBounds = true
    
    toolbarBottom = UIToolbar(frame: CGRect(x: 0, y: frame.height - 25, width: frame.width, height: 25))
    toolbarBottom.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    toolbarBottom.clipsToBounds = true
    
    title = UILabel(frame: CGRect(x: 10, y: 0, width: (frame.width * 3 / 4) - 20, height: 40))
    title.autoresizingMask = [.flexibleWidth]
    title.font = robotoRegularFont
    
    playPause = UIButton(type: .custom)
    playPause.titleLabel?.font = ooyalaFont.withSize(40)
    playPause.setTitle("h", for: .normal)
    playPauseBtn = UIBarButtonItem(customView: playPause)
    
    fullscreen = UIButton(type: .custom)
    fullscreen.titleLabel?.font = ooyalaFont
    fullscreenBtn = UIBarButtonItem(customView: fullscreen)
    
    closedCaptions = UIButton(type: .custom)
    closedCaptions.titleLabel?.font = ooyalaFont
    closedCaptions.setTitle("F", for: .normal)
    closedCaptionsBtn = UIBarButtonItem(customView: closedCaptions)
  }
  
  func syncUI() {
    subviews.forEach({ $0.removeFromSuperview() })
    toolbarTop.subviews.forEach({ $0.removeFromSuperview() })
    toolbarTop.setItems([], animated: false)
    toolbarMid.setItems([], animated: false)
    toolbarBottom.setItems([], animated: false)
    
    if isFullscreen {
      fullscreen.setTitle("j", for: .normal)
    }
    else {
      fullscreen.setTitle("i", for: .normal)
      toolbarTop.addSubview(title)
      toolbarTop.setItems([flexibleSpace, closedCaptionsBtn], animated: false)
      toolbarMid.setItems([playPauseBtn], animated: false)
      toolbarBottom.setItems([flexibleSpace], animated: false)
      
      addSubview(toolbarTop)
      addSubview(toolbarMid)
      addSubview(toolbarBottom)

    }
  }
  
}
