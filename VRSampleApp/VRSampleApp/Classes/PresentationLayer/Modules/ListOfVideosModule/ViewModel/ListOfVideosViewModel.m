//
//  ListOfVideosViewModel.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "ListOfVideosViewModel.h"
#import "ListOfVideosFactory.h"
#import "TestDataServiceProtocol.h"
#import "TestDataService.h"
#import "VideoItemSection.h"
#import "VideoItem.h"

@interface ListOfVideosViewModel ()

#pragma mark - Private properties

@property (nonatomic) id <TestDataServiceProtocol> testDataService;
@property (nonatomic) ListOfVideosFactory *listOfVideosFactory;
@property (nonatomic) NSArray *testData;

extern NSString *kDefaultPCode;
extern NSString *kDefaultDomain;
extern NSString *kCustomVideoTitle;

@end


@implementation ListOfVideosViewModel

#pragma mark - Constants

NSString *kDefaultPCode = @"BzY2syOq6kIK6PTXN7mmrGVSJEFj";
NSString *kDefaultDomain = @"http://www.ooyala.com";
NSString *kCustomVideoTitle = @"Custom video";

#pragma mark - Initialization

- (instancetype)init {
  if (self = [super init]) {
    // DI
    _testDataService = [TestDataService new];
    _listOfVideosFactory = [ListOfVideosFactory new];
    
    // Load items
    _testData = [NSArray array];
    _testData = [self.testDataService obtainTestData];
  }
  
  return self;
}

#pragma mark - Public functions

- (NSInteger)getCountSections {
  return self.testData.count;
}

- (NSInteger)getCountRowsInSection:(NSInteger)section {
  if (section < self.testData.count) {
    VideoItemSection *videoItemSection = self.testData[section];
    return videoItemSection.videoItems.count;
  }
  
  return 0;
}

- (VideoItemSection *)getVideoItemSectionAtSection:(NSInteger)section {
  if (section < self.testData.count) {
    return self.testData[section];
  }
  
  return NULL;
}

- (VideoItem *)getVideoItemAt:(NSIndexPath *)indexPath {
  if (indexPath.section < self.testData.count) {
    VideoItemSection *videoItem = self.testData[indexPath.section];
    if (indexPath.row < videoItem.videoItems.count) {
      return videoItem.videoItems[indexPath.row];
    }
  }
  
  return NULL;
}

- (UIViewController *)configuredCustomVideoViewControllerWithCompletion:(void (^)(VideoItem *videoItem))completion {
  return [self.listOfVideosFactory configuredCustomVideoViewControllerWithCompletion:^(NSString *pCode, NSString *embedCode) {
    VideoItem *videoItem = [[VideoItem alloc] initWithEmbedCode:embedCode andTitle:kCustomVideoTitle];
    videoItem.pcode = pCode;
    videoItem.videoAdType = UNKNOWN;
    
    completion(videoItem);
  }];
}

- (UIViewController *)configuredVideoViewControllerWithVideoItem:(VideoItem *)videoItem
                                                andQAModeEnabled:(BOOL)QAModeEnabled {
  NSString *pcode;
  if (videoItem.pcode) {
    pcode = videoItem.pcode;
  } else {
    pcode = kDefaultPCode;
  }
  
  return [self.listOfVideosFactory viewControllerWithVideoItem:videoItem
                                                         pcode:pcode
                                                        domain:kDefaultDomain
                                                 QAModeEnabled:QAModeEnabled];
}

@end
