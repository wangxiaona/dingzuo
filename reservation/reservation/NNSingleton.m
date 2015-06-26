//
//  NNSingleton.m
//  reservation
//
//  Created by 王晓娜 on 15/6/17.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "NNSingleton.h"

@implementation NNSingleton

+ (NNSingleton *)sharedSingleton
{
    static NNSingleton *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[NNSingleton alloc] init];
           
        }
        return sharedSingleton;
    }
}



-(NSString *) filePathplist_userId
{
    NSArray * array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docPath = [array objectAtIndex:0];
    NSString * fileName = [docPath stringByAppendingPathComponent:@"user.plist"];
    return fileName;
}

-(void)saveUserId:(NSString *)string
{
    NSMutableArray *arr_read = [NSMutableArray arrayWithCapacity:0];
    [arr_read addObjectsFromArray:[self readUserId_all][@"user"]];
    if([arr_read containsObject:string])
    {
        [arr_read removeObject:string];
    }
    [arr_read addObject:string];
    [[NSMutableDictionary dictionaryWithObjectsAndKeys:arr_read,@"user", nil] writeToFile:[self filePathplist_userId] atomically:YES];
    
    
}
-(NSDictionary *)readUserId_all
{
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[self filePathplist_userId]];
    return dic;
    
}

-(NSString *)readUserId
{
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[self filePathplist_userId]];
    NSArray *arr_user = dic[@"user"];
    if(arr_user.count)
        return [arr_user lastObject];
    else
        return @"";
    
}
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}
@end
