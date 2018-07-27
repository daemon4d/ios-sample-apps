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
      PlayerSelectionOption(embedCode: "JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            title: "HLS Video (Long)",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      // if required, add more test cases here
    ]
  }
  
}
