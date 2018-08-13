//
//  OOCastManagerFetcher.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class OOCastManagerFetcher: NSObject {
  
  class func fetchCastManager() -> OOCastManager {
    return OOCastManager(appID: "4172C76F", namespace: "urn:x-cast:ooyala")
  }

}
