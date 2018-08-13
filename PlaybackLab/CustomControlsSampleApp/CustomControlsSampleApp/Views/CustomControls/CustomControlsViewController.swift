//
//  CustomControlsViewController.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class CustomControlsViewController: OOControlsViewController, OOCastManagerDelegate {
  
  private(set) var controlsType: OOOoyalaPlayerControlType!
  
  private var customControls: CustomControls {
    get{
      return controls as! CustomControls
    }
  }
  
  private var castManager: OOCastManager!
  
  private let interval = 0.1
  private var timerSlider: Timer?
  private var state: OOOoyalaPlayerState?
  
  override init(controlsType: OOOoyalaPlayerControlType, player: OOOoyalaPlayer!, overlay: UIView!, delegate: Any!) {
    super.init(controlsType: controlsType, player: player, overlay: overlay, delegate: delegate)
    self.controlsType = controlsType
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override var prefersStatusBarHidden: Bool {
    if controls != nil && customControls.isFullscreen {
      return true
    }
    return false
  }
  
  override func viewDidLoad() {
    if player == nil {
      return
    }
    
    castManager = OOCastManagerFetcher.fetchCastManager()
    castManager.delegate = self
    
    player.initCastManager(castManager)
    
    controls = CustomControls(frame: view.bounds, castManager: castManager, controlsType: controlsType)
    
    customControls.playPause.addTarget(self, action: #selector(playPause), for: .touchDown)
    customControls.fullscreen.addTarget(self, action: #selector(fullscreen), for: .touchDown)
    customControls.sliderTime.addTarget(self, action: #selector(didStartDragging(sender:event:)), for: .valueChanged)
        customControls.sliderTime.addTarget(self, action: #selector(test), for: .touchDown)

    super.viewDidLoad()
  }
  
  @objc
  private func test(){
    print("TEEEST")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(playerStateChanged), name:NSNotification.Name.OOOoyalaPlayerStateChanged, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(playerTimeChanged), name: NSNotification.Name.OOOoyalaPlayerTimeChanged, object: nil)
    
    timerSlider = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(updateSliderTime), userInfo: nil, repeats: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timerSlider?.invalidate()
    timerSlider = nil
    NotificationCenter.default.removeObserver(self)
  }
  
  override func syncUI() {
    if player != nil && controls != nil {
      if player.volume != 0 {
        customControls.volume.setTitle("b", for: .normal)
      }
      else {
        customControls.volume.setTitle("p", for: .normal)
      }
      customControls.syncUI()
      playerStateChanged()
      playerTimeChanged()
    }
  }
  
  func currentTopUIViewController() -> UIViewController! {
    var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    while (topController?.presentedViewController != nil) {
      topController = topController?.presentedViewController
    }
    return topController

  }
  
  @objc
  private func playerStateChanged(){
    if player != nil && controls != nil {
      DispatchQueue.main.async {
        self.customControls.title.text = self.player.currentItem?.title
        self.customControls.playheadTime.text = "\(Utils.stringFromTimeInterval(interval: self.player.playheadTime())) - \(Utils.stringFromTimeInterval(interval: self.player.duration()))"
        self.customControls.playheadTime.sizeToFit()
      }
      switch player.state() {
      case .playing:
        DispatchQueue.main.async {
          self.customControls.playPause.setTitle("g", for: .normal)
        }
        break
      case .paused:
        DispatchQueue.main.async {
          self.customControls.playPause.setTitle("h", for: .normal)
        }
        break
      case .completed:
        DispatchQueue.main.async {
          self.customControls.playPause.setTitle("c", for: .normal)
        }
        break
      default:
        break
      }
    }
  }
  
  @objc
  private func updateSliderTime(){
    if controls != nil {
      DispatchQueue.main.async {
        let value = 100.0 * Float(self.player.playheadTime() / self.player.duration())
        self.customControls.sliderTime.value = value
        self.customControls.playheadTime.text = "\(Utils.stringFromTimeInterval(interval: self.player.playheadTime())) - \(Utils.stringFromTimeInterval(interval: self.player.duration()))"
        self.customControls.playheadTime.sizeToFit()
      }
    }
  }
  
  @objc
  private func didStartDragging(sender: UISlider, event: UIEvent){
    if let touchEvent = event.allTouches?.first {
      switch touchEvent.phase {
      case .began, .stationary, .moved:
        timerSlider?.invalidate()
        timerSlider = nil
        state = player.state()
        player.pause()
        break
      case .ended:
        let value = Float64(sender.value) * (player.duration() / 100.0)
        player.seek(value)
        if state == .playing {
          player.play()
        }
        timerSlider = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(updateSliderTime), userInfo: nil, repeats: true)
        break
      default:
        timerSlider = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(updateSliderTime), userInfo: nil, repeats: true)
        break
      }
    }
  }
  
  @objc
  private func playerTimeChanged(){
    if player != nil && controls != nil {
      DispatchQueue.main.async {
        self.customControls.playheadTime.text = "\(Utils.stringFromTimeInterval(interval: self.player.playheadTime())) - \(Utils.stringFromTimeInterval(interval: self.player.duration()))"
        self.customControls.playheadTime.sizeToFit()
      }
    }
  }
  
  @objc
  private func playPause(){
    if player.isPlaying() {
      player.pause()
    }
    else {
      player.play()
    }
  }
  
  @objc
  private func fullscreen(){
    if customControls.isFullscreen {
      delegate.setFullscreen(false)
    }
    else {
      delegate.setFullScreen(CustomControlsViewController(controlsType: .fullScreen,
                                                          player: player,
                                                          overlay: overlay,
                                                          delegate: delegate))
      delegate.setFullscreen(true)
    }
    customControls.syncUI()
  }

  deinit {
  }
  
}
