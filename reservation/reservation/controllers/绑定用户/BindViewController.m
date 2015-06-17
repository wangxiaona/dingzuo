//
//  BindViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/16.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "BindViewController.h"
#import "SubCateViewController.h"
#import "CateTableViewCell.h"

@interface BindViewController ()<UIFolderTableViewDelegate>
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
-(void)bangdingPressed:(UIBarButtonItem *)sender
{
    NSLog(@"bangdingPressed");
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
            cell.label1.text = @"身份认证类型";
            cell.textField1.userInteractionEnabled = NO;
            cell.textField1.text = self.type[@"title"];
            cell.textField1.placeholder = [NSString stringWithFormat:@"请选择%@",cell.label1.text];
        }
            break;
            
        case 1:
        {
            cell.label1.text = @"身份认证编号";
            cell.textField1.userInteractionEnabled = YES;
            cell.textField1.text = self.verifyNum;
            cell.textField1.placeholder = [NSString stringWithFormat:@"请填写%@",cell.label1.text];
        }
            break;
            
        case 2:
        {
            cell.label1.text = @"会馆编号";
            cell.textField1.userInteractionEnabled = YES;
            cell.textField1.text = self.huiguanNum;
            cell.textField1.placeholder = [NSString stringWithFormat:@"请填写%@",cell.label1.text];
        }
            break;
            
        default:
            break;
    }
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
