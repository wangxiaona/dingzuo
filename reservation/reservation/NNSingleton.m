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


- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}
@end
