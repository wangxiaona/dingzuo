//
//  NNSingleton.h
//  reservation
//
//  Created by 王晓娜 on 15/6/17.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNSingleton : NSObject

-(void)saveUserId:(NSString *)dic;
-(NSString *)readUserId;
+ (NNSingleton *)sharedSingleton;
- (void)setExtraCellLineHidden: (UITableView *)tableView;
@end
