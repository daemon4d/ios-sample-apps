//
//  CustomControlsViewController.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class CustomControlsViewController: OOControlsViewController {
  
  private(set) var controlsType: OOOoyalaPlayerControlType!
  
  private var customControls: CustomControls {
    get{
      return controls as! CustomControls
    }
  }
  
  private var updateSlider = true
  
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
    
    controls = CustomControls(frame: view.bounds, controlsType: controlsType)
    
    customControls.playPause.addTarget(self, action: #selector(playPause), for: .touchDown)
    customControls.sliderTime.addTarget(self, action: #selector(sliderValueChanged(_:event:)), for: .valueChanged)
    customControls.fullscreen.addTarget(self, action: #selector(fullscreen), for: .touchDown)
    
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(playerStateChanged), name:NSNotification.Name.OOOoyalaPlayerStateChanged, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(playerTimeChanged), name: NSNotification.Name.OOOoyalaPlayerTimeChanged, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
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
  
  @objc
  private func playerStateChanged(){
    if player != nil && controls != nil {
      DispatchQueue.main.async {
        self.customControls.title.text = self.player.currentItem?.title
        
        if self.customControls.sliderTime.maximumValue == 0 {
          self.customControls.sliderTime.minimumValue = 0
          self.customControls.sliderTime.maximumValue = Float(self.player.duration())
        }

       //
        
        self.customControls.playheadTime.text = "\(Utils.stringFromTimeInterval(interval: self.player.playheadTime())) - \(Utils.stringFromTimeInterval(interval: self.player.duration()))"
        self.customControls.playheadTime.sizeToFit()
      }
      switch player.state() {
      case .playing:
        DispatchQueue.main.async {
          if self.updateSlider {
            self.customControls.sliderTime.value = Float(self.player.playheadTime())
          }
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
  private func sliderValueChanged(_ sender: UISlider, event: UIEvent){
    if player != nil && controls != nil {
      if let touchEvent = event.allTouches?.first {
        switch touchEvent.phase {
        case .began:
          print("phase : began")
          player.pause()
          updateSlider = false
          break
        case .ended:
          print("phase : ended ")
          updateSlider = true
          player.seek(Float64(sender.value))
          player.play()
          break
        default:
          //print("phase : \(touchEvent.phase)")
          break
        }
      }
     
   /*   if let touchEvent = event.allTouches?.first {
        print("values: \(touchEvent.phase)")

        switch touchEvent.phase {
        case .ended:
          print("values: \(Float64(sender.value))")
          player.seek(Float64(sender.value))
          updateSlider = true
          break
        default:
          updateSlider = false
          break
        }
      }*/
      
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
