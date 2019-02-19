//
//  PlayerSelectionOption.h
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerSelectionOption : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *embedCode;

- (instancetype)initWithTitle:(NSString *)title pcode:(NSString *)pcode embedCode:(NSString *)embedCode;

@end
