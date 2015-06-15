//
//  EXTManager.m
//  EXTW
//
//  Created by wangxiang on 9/18/14.
//  Copyright (c) 2014 wangxiang. All rights reserved.
//

#import "NNManager.h"
@implementation NNManager

{
    BOOL isFirstNoNet;
}
@synthesize isFirstNoNet;
+(instancetype)sharedInterface
{
    static NNManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NNManager alloc] initWithBaseURL:BASE_URL];
    });
    return _sharedClient;
}
+(void)reachNet:(UIView*)shoView
{
    NNManager *manager = [[NNManager alloc]init];
    
    [AFNetworkReachabilityManager managerForDomain:@"www.baidu.cn"];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
            {
                
            }
                break;
            case  AFNetworkReachabilityStatusNotReachable:{
                manager.isFirstNoNet = YES;
                //
                [SVProgressHUD showErrorWithStatus:@"网络无连接"];
            }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                if (manager.isFirstNoNet==YES) {
                    
                    [SVProgressHUD showErrorWithStatus:@"当前3G网络"];
                    
                    //
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                if (manager.isFirstNoNet==YES) {
                
                [SVProgressHUD showErrorWithStatus:@"当前网络WiFi"];
                
                }
            }
                break;
            default:
                break;
        }
        
    }];
    
}
-(void)stopRequestData
{
    [self.operationQueue cancelAllOperations];
}
@end
