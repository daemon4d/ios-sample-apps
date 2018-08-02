//
//  PlayerViewController.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
  
  @IBOutlet weak var playerView: UIView!
  
  // Properties for the video
  var option: PlayerSelectionOption!
  
  // Properties required for a Fairplay asset
  private var apiKey: String?
  private var apiSecret: String?
  
  private var ooyalaPlayerViewController: OOOoyalaPlayerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = option.title
    
    var player: OOOoyalaPlayer!
    if option.embedTokenGenerator != nil {
      if let embedTokenGen = option.embedTokenGenerator as? BasicEmbedTokenGenerator {
        // If you're using the BasicEmbedTokenGenerator we provided in this sample app, this block will be called.
        // Check the OptionsDataSource class to see how we define the assets for the app and how we add a reference
        // to a BasicEmbedTokenGenerator to a given asset.
        apiKey = embedTokenGen.apiKey
        apiSecret = embedTokenGen.apiSecret
      }
      else {
        // If you're not using the BasicEmbedTokenGenerator provided in the example,
        // supply your own API_KEY and API_SECRET
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      
      let options: OOOptions = OOOptions()!
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production.
      // In production, you should implement your own OOSecureURLGenerator which contacts a server of your own,
      // which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey,
                                                                secret: apiSecret)!
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain,
                              embedTokenGenerator: option.embedTokenGenerator!,
                              options: options)
    }
    else {
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain)
    }
    player.setEmbedCode(option.embedCode)
    player.volume = 0
    ooyalaPlayerViewController = OOOoyalaPlayerViewController(player: player)
    ooyalaPlayerViewController.setInline(CustomControlsViewController(controlsType: .inline,
                                                                      player: player,
                                                                      overlay: nil,
                                                                      delegate: ooyalaPlayerViewController))
    
    addChildViewController(ooyalaPlayerViewController)
    player.view.frame = playerView.bounds
    playerView.addSubview(ooyalaPlayerViewController.view)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    
  }
  
  deinit {
    print("Deinit PlayerViewController")
  }
  
}
