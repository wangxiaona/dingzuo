//
//  UserListViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/16.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "UserListViewController.h"
#import "UserTableViewCell.h"
#import "CateTableViewCell.h"

@interface UserListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)IBOutlet UITableView *tableView;
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"绑定用户信息";
    [self setCustomizeBackBar];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tableViewList = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *dic_userdetail = [[NNSingleton sharedSingleton] readUserDetail];
    for(NSString *string in [dic_userdetail allKeys])
    {
        [self.tableViewList addObject:@{string:dic_userdetail[string]}];
    }
    if(self.tableViewList.count == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"未绑定用户"];
    }
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.tableViewList objectAtIndex:indexPath.section];
    static NSString *cellIdentifier = @"bind_cell";
    CateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CateTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.label1.text = [[dic allKeys] lastObject];
    cell.textField1.text = [[dic allValues] lastObject];
    cell.textField1.userInteractionEnabled = NO;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.tableViewList.count)
        return 1;
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
