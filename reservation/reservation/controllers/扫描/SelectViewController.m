//
//  SelectViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/17.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "SelectViewController.h"
#import "GroupTableViewCell.h"
#import "ProjectTableViewCell.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setCustomizeBackBar];
    self.tableViewList = [NSMutableArray arrayWithCapacity:0];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    products数组中对象的值包含以下属性：
//    id						--->编号
//    product.name        	--->名称
//    remainValidMoney   		--->剩余余额
//    remainUseTimes			--->剩余次数
//    remainValidTime			--->剩余时间
//    
//    groups数组中对象的值包含以下属性：
//    id						--->编号
//    groupNo					--->字符串类型编号
//    name					--->名称
//    manager					--->负责人
    
    NSDictionary *dic = self.tableViewList[indexPath.row];
    switch (self.type_n) {
        case YES:
        {
            static NSString *cellIdentifier = @"projectsCell";
            ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ProjectTableViewCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            return cell;
        }
            break;
        case NO:
        {
            static NSString *cellIdentifier = @"groupsCell";
            GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"GroupTableViewCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            return cell;
        }
            break;
        default:
            break;
    };
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.type_n?150:120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewList.count;
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
