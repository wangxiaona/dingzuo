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
    
    [[NNSingleton sharedSingleton] setExtraCellLineHidden:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    if(self.type_n)
    {
        self.title = @"选择产品";
    }else{
        self.title = @"选择班级";
    }
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return self.type_n?125:95;
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
