//
//  BindViewController.m
//  reservation
//
//  Created by iOS开发 on 15/6/16.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "BindViewController.h"
#import "SubCateViewController.h"
#import "CateTableViewCell.h"

@interface BindViewController ()<UIFolderTableViewDelegate,UITextFieldDelegate>
{
    SubCateViewController *subVc;
}
@end

@implementation BindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"绑定用户";
    [self setCustomizeBackBar];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"绑定" target:self action:@selector(bangdingPressed:)];
    
    self.type = @{@"title":@"会员编号",@"keyword":@"memberId"};
    
    subVc = [[SubCateViewController alloc]
             initWithNibName:NSStringFromClass([SubCateViewController class])
             bundle:nil];
    subVc.bindVc = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.verifyTypeNum = @"";
    self.verifyNum = @"";
    self.huiguanNum = @"";
    self.navigationController.navigationBarHidden = NO;
}
-(void)bangdingPressed:(UIBarButtonItem *)sender
{
//    用户初次使用app，或本地未存储（或各种原因身份认证丢失）身份认证信息时，需要对用户进行身份认证，此认证仅仅将用户的身份认证数据进行本地化存储，并不发出请求向远程服务器认证。建议存储的格式为key=value&key=value格式。
    
    NSLog(@"bangdingPressed");
    [SVProgressHUD showWithStatus:@"正在绑定，请稍候"];
    
    CateTableViewCell *cell = (CateTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CateTableViewCell *cell2 = (CateTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CateTableViewCell *cell3 = (CateTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    self.verifyTypeNum = cell.textField1.text;
    self.verifyNum = cell2.textField1.text;
    self.huiguanNum = cell3.textField1.text;
    
    NSDictionary *dic = @{self.type[@"title"]:self.verifyTypeNum,@"身份认证编号":self.verifyNum,@"会馆编号":self.huiguanNum};
    [[NNSingleton sharedSingleton] saveUserDetail:dic];
    
    if(!self.verifyTypeNum.length)
    {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请填写%@",self.type[@"title"]]];
        return;
    }
//    else if(!self.verifyNum.length)
//    {
//        [SVProgressHUD showErrorWithStatus:@"请填写身份认证编号"];
//        return;
//    }
//    else if(!self.huiguanNum.length)
//    {
//        [SVProgressHUD showErrorWithStatus:@""];
//        return;
//    }
    NSString *string_append = @"";
    if([self.type[@"keyword"] isEqualToString:@"memberId"])
    {
        string_append = [NSString stringWithFormat:@"&%@=%@",self.type[@"keyword"],self.verifyTypeNum];
    }
    else
    {
        string_append = [NSString stringWithFormat:@"&authenticateType=%@&authenticateAccount=%@",self.type[@"keyword"],self.verifyTypeNum];
    }
    [[NNSingleton sharedSingleton] saveUserId:string_append];
    
    [self performSelector:@selector(loginseccess_n) withObject:nil afterDelay:0.5];
//    [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
//    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)loginseccess_n
{
    [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CateTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.label1.text = @"会员编号";
            cell.label1.text = self.type[@"title"];
            cell.textField1.text = self.verifyTypeNum;
        }
            break;
            
        case 1:
        {
            cell.label1.text = @"身份认证编号";
            cell.textField1.text = self.verifyNum;
        }
            break;
            
        case 2:
        {
            cell.label1.text = @"会馆编号";
            cell.textField1.text = self.huiguanNum;
        }
            break;
            
        default:
            break;
    }
    cell.userInteractionEnabled = YES;
    cell.textField1.placeholder = [NSString stringWithFormat:@"请填写%@",cell.label1.text];
    cell.textField1.tag = indexPath.row;

    [cell.textField1 setDelegate:self];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0)
        return;
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
    
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)subCateBtnAction:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
            self.type = @{@"title":@"会员编号",@"keyword":@"memberId"};
            break;
            
        case 2:
            self.type = @{@"title":@"卡号",@"keyword":@"cardno"};
            break;
            
        case 3:
            self.type = @{@"title":@"卡外码",@"keyword":@"outcardno"};
            break;
            
        case 4:
            self.type = @{@"title":@"手机号",@"keyword":@"mobile"};
            break;
            
        default:
            break;
    }
    subVc.lastButton.selected = NO;
    btn.selected = YES;
    subVc.lastButton = btn;
    [self.tableView performClose:nil];
    [self.tableView reloadData];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)selectVerifyType
{
    
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
