//
//  CustomControls.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class CustomControls: UIView {
  
  private var castManager: OOCastManager!

  private(set) var isFullscreen = false
  private(set) var isAirplay = false
  private(set) var isCast = false
  
  // Font
  private let ooyalaFont = UIFont(name: "ooyala-slick-type", size: 25)!
  private let robotoRegularFont = UIFont(name: "Roboto-Regular", size: 12)!
  private let robotoBoldFont = UIFont(name: "Roboto-Bold", size: 12)!
  
  // Spaces
  private let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  private let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
  
  private var toolbarTop: UIToolbar!
  private var toolbarMid: UIToolbar!
  private var toolbarScrubber: UIToolbar!
  private var toolbarBottom: UIToolbar!
  
  private(set) var title: UILabel!
  
  private(set) var airplay: UIButton!
  private var airplayItem: UIBarButtonItem!
  
  private(set) var chromecast: UIButton!
  private var chromecastItem: UIBarButtonItem!
  
  private(set) var playPause: UIButton!
  private var playPauseItem: UIBarButtonItem!
  
  private(set) var sliderTime: UISlider!
  private var sliderTimeItem: UIBarButtonItem!
  
  private(set) var volume: UIButton!
  private var volumeItem: UIBarButtonItem!
  
  private(set) var playheadTime: UILabel!
  private var playheadTimeItem: UIBarButtonItem!
  
  private(set) var fullscreen: UIButton!
  private var fullscreenItem: UIBarButtonItem!
  
  private(set) var closedCaptions: UIButton!
  private var closedCaptionsItem: UIBarButtonItem!
  
  init(frame: CGRect, castManager: OOCastManager, controlsType: OOOoyalaPlayerControlType) {
    super.init(frame: frame)
    self.castManager = castManager
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    isFullscreen = controlsType == .fullScreen ? true : false
    
    initToolbars()
    initButtons()
    syncUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Init
  private func initToolbars(){
    toolbarTop = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
    toolbarTop.setBackgroundImage(UIImage().tintWithColor(color: .red, alpha: 0.2), forToolbarPosition: .any, barMetrics: .default)
    toolbarTop.autoresizingMask = .flexibleWidth
    toolbarTop.clipsToBounds = true
    
    toolbarMid = UIToolbar(frame: CGRect(x: frame.width / 2 - 50, y: frame.height / 2 - 30, width: 100, height: 60))
    toolbarMid.setBackgroundImage(UIImage().tintWithColor(color: .clear, alpha: 0), forToolbarPosition: .any, barMetrics: .default)
    toolbarMid.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
    toolbarMid.clipsToBounds = true
    
    toolbarScrubber = UIToolbar(frame: CGRect(x: 0, y: frame.height - 65, width: frame.width, height: 25))
    toolbarScrubber.setBackgroundImage(UIImage().tintWithColor(color: .red, alpha: 0.2), forToolbarPosition: .any, barMetrics: .default)
    toolbarScrubber.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    toolbarScrubber.clipsToBounds = true
    
    toolbarBottom = UIToolbar(frame: CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 40))
    toolbarBottom.setBackgroundImage(UIImage().tintWithColor(color: .red, alpha: 0.2), forToolbarPosition: .any, barMetrics: .default)
    toolbarBottom.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    toolbarBottom.clipsToBounds = true
  }
  
  private func initButtons(){
    fixedSpace.width = 5
    
    title = UILabel(frame: CGRect(x: 20, y: 0, width: (frame.width * 3 / 4) - 40, height: 40))
    title.autoresizingMask = [.flexibleWidth]
    title.font = robotoBoldFont.withSize(15)
    title.textColor = .white
    
    airplay = UIButton(type: .custom)
    airplay.titleLabel?.font = ooyalaFont
    airplay.setTitle("{", for: .normal)
    airplayItem = UIBarButtonItem(customView: airplay)
    
    /*chromecast = UIButton(type: .custom)
    chromecast.titleLabel?.font = ooyalaFont
    chromecast.setTitle("}", for: .normal)*/
    chromecast = castManager.castButton()
    chromecastItem = UIBarButtonItem(customView: chromecast)
    
    playPause = UIButton(type: .custom)
    playPause.titleLabel?.font = ooyalaFont.withSize(60)
    playPause.setTitle("h", for: .normal)
    playPauseItem = UIBarButtonItem(customView: playPause)
    
    sliderTime = UISlider(frame: CGRect(x: 0, y: 0, width: frame.width, height: 25))
    sliderTime.autoresizingMask = [.flexibleWidth]
    sliderTime.setThumbImage(UIImage.createThumbImage(size: 25, color: .blue), for: .normal)
    sliderTime.minimumValue = 0.0
    sliderTime.maximumValue = 100.0
    sliderTime.value = 0.0
    sliderTimeItem = UIBarButtonItem(customView: sliderTime)
    
    volume = UIButton(type: .custom)
    volume.titleLabel?.font = ooyalaFont
    volumeItem = UIBarButtonItem(customView: volume)
    
    playheadTime = UILabel(frame: CGRect.zero)
    playheadTime.textColor = .white
    playheadTime.font = robotoBoldFont.withSize(15)
    playheadTime.text = "00:00 - 00:00"
    playheadTimeItem = UIBarButtonItem(customView: playheadTime)
    
    fullscreen = UIButton(type: .custom)
    fullscreen.titleLabel?.font = ooyalaFont
    fullscreenItem = UIBarButtonItem(customView: fullscreen)
    
    closedCaptions = UIButton(type: .custom)
    closedCaptions.titleLabel?.font = ooyalaFont
    closedCaptions.setTitle("F", for: .normal)
    closedCaptionsItem = UIBarButtonItem(customView: closedCaptions)
  }
  
  func syncUI() {
    subviews.forEach({ $0.removeFromSuperview() })
    toolbarTop.setItems([], animated: false)
    toolbarMid.setItems([], animated: false)
    toolbarScrubber.setItems([], animated: false)
    toolbarBottom.setItems([], animated: false)
    
    if isAirplay {
      
    }
    else if isCast {
      
    }
    else {
      if isFullscreen {
        fullscreen.setTitle("j", for: .normal)
      }
      else {
        fullscreen.setTitle("i", for: .normal)
      }
      
      toolbarTop.addSubview(title)
      toolbarTop.setItems([flexibleSpace, airplayItem, fixedSpace, chromecastItem], animated: false)
      addSubview(toolbarTop)
      
      toolbarMid.setItems([playPauseItem], animated: false)
      addSubview(toolbarMid)
      
      toolbarScrubber.setItems([sliderTimeItem], animated: false)
      addSubview(toolbarScrubber)
      
      toolbarBottom.setItems([volumeItem, fixedSpace, playheadTimeItem, flexibleSpace, fullscreenItem], animated: false)
      addSubview(toolbarBottom)
    }
    super.setNeedsLayout()
  }
  
}
