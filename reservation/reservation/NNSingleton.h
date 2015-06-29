//
//  NNSingleton.h
//  reservation
//
//  Created by iOS开发 on 15/6/17.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNSingleton : NSObject

-(void)saveUserId:(NSString *)dic;
-(NSString *)readUserId;
+ (NNSingleton *)sharedSingleton;

-(void)saveUserDetail:(NSDictionary *)string;

-(NSDictionary *)readUserDetail;

- (void)setExtraCellLineHidden: (UITableView *)tableView;
@end
