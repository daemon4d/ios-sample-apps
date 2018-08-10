//
//  OptionDataSource.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class OptionDataSource: NSObject {
  
  class func options() -> [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(embedCode: "hranJ4ZjE6CNbm17ozwyDPOMqVbmVRoc",
                            pcode: "ZsdGgyOnugo44o442aALkge_dVVK",
                            title: "HLS Video",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      // if required, add more test cases here
    ]
  }
  
}
