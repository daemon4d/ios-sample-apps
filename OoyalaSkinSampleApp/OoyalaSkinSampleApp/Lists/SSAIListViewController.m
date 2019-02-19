//
//  SSAIListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SSAIListViewController.h"
#import "SSAIPlayerViewController.h"

@interface SSAIListViewController ()

@end

@implementation SSAIListViewController

- (void)addTestCases {
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Ooyala Pulse2"
                                                            embedCode:@"lwd3hkZjE6o7hAYZlr-Wgn9MjnE_dtNT"
                                                                pcode:@"ViM2wyOicnaFHWsz2iQQj25bnQ32"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"ooyala_pulse"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Google DFP"
                                                            embedCode:@"ZhbzNiZzE64qnD5YMEnoi2DcwqSfH4z8"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"google_dfp"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Ooyala Pulse / CC DFXP"
                                                            embedCode:@"8yZXE0ZzE6596qdcG58aTnvzADUBLC2I"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"ooyala_pulse"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / VOD / Google DFP / CC DFXP"
                                                            embedCode:@"54ZHE0ZzE6JQBu_T099L8NWvzzqsnrKG"
                                                                pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"google_dfp"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / LIVE / Ooyala Pulse"
                                                            embedCode:@"lkb2cyZjE6wp94YSGIEjm6Em1yH0P3zT"
                                                                pcode:@"RpOWUyOq86gFq-STNqpgzhzIcXHV"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"ooyala_pulse"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
  [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"SSAI / LIVE / Google DFP"
                                                            embedCode:@"s2M213ZDE6A-DU2Tr-k0DI-8PgnFIcmU"
                                                                pcode:@"RpOWUyOq86gFq-STNqpgzhzIcXHV"
                                                         playerDomain:@"http://www.ooyala.com"
                                                        adSetProvider:@"google_dfp"
                                                       viewController:[SSAIPlayerViewController class] nib: @"SSAIPlayerViewController"]];
}

@end
