//
//  EXTManager.h
//  EXTW
//
//  Created by wangxiang on 9/18/14.
//  Copyright (c) 2014 wangxiang. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
@interface NNManager : AFHTTPRequestOperationManager

@property (nonatomic, assign) BOOL isFirstNoNet;
+(instancetype)sharedInterface;
+(void)reachNet:(UIView*)shoView;
-(void)stopRequestData;
@end
