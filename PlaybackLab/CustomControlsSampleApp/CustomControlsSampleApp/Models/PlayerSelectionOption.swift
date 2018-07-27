//
//  PlayerSelectionOption.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class PlayerSelectionOption: NSObject {
  
  private(set) var embedCode: String
  
  private(set) var pcode: String
  
  private(set) var title: String
  
  private(set) var domain: OOPlayerDomain
  
  private(set) weak var embedTokenGenerator: OOEmbedTokenGenerator?
  
  init(embedCode: String, pcode: String, title: String, domain: OOPlayerDomain) {
    self.embedCode = embedCode
    self.pcode = pcode
    self.domain = domain
    self.title = title
    super.init()
  }
  
  convenience init(embedCode: String, pcode: String, title: String, domain: OOPlayerDomain, embedTokenGenerator: OOEmbedTokenGenerator) {
    self.init(embedCode: embedCode,
              pcode: pcode,
              title: title,
              domain: domain)
    self.embedTokenGenerator = embedTokenGenerator
  }
  
}
