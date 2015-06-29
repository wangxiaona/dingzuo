//
//  FirstViewController.m
//  reservation
//
//  Created by iOS开发 on 15/6/15.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "FirstViewController.h"
#import "UserListViewController.h"
#import "BindViewController.h"
#import "TimeTableViewController.h"
#import "SelectViewController.h"
#import "ZBarSDK.h"

@interface FirstViewController ()<ZBarReaderDelegate>
{
    UserListViewController *userListController;
    BindViewController *bindController;
    TimeTableViewController *timetableController;
    SelectViewController *selectViewController;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
    
    [self.view setFrame:[UIScreen mainScreen].bounds];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
    self.pointView.layer.cornerRadius = 4.0f;
    self.pointView.layer.masksToBounds = YES;
    
    userListController = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
    bindController = [[BindViewController alloc] initWithNibName:@"BindViewController" bundle:nil];
    timetableController = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
    selectViewController = [[SelectViewController alloc] initWithNibName:@"SelectViewController" bundle:nil];
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
- (IBAction)verifyListButtonPressed:(id)sender {
    [self.navigationController pushViewController:userListController animated:YES];
}
- (IBAction)verifyButtonPressed:(id)sender {
    [self.navigationController pushViewController:bindController animated:YES];
}
- (IBAction)scanButtonPressed:(id)sender {
    
    //    扫描二维码
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsZBarControls=NO;
//    reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);
    
    [self setOverlayPickerView:reader];
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    if(self.timer == nil)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animations_nn) userInfo:nil repeats:YES];
    }
    else
        [self.timer setFireDate:[NSDate date]];
   
    
    [self presentViewController:reader animated:YES completion:nil];
    
    
}
-(void)animations_nn
{
    self.pointView.hidden  = self.pointView.hidden?NO:YES;
}

- (IBAction)timetableButtonPressed:(id)sender {
//    [self.navigationController pushViewController:timetableController animated:YES];
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSString *string = symbol.data;
    NSLog(@"%@",string);
    
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *string_memberid = [[NNSingleton sharedSingleton] readUserId];
    NSString * api = [string stringByAppendingString:string_memberid];
    NSLog(@"%@",api);
    
    [reader dismissViewControllerAnimated:YES completion:nil];

    [[NNManager sharedInterface]GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [SVProgressHUD dismiss];
        if([responseObject[@"success"]boolValue])
        {
            NSString *nextStep = [NSString stringWithFormat:@"%@",responseObject[@"nextStep"]];
            NSDictionary *dataDic = responseObject[@"data"];
            NSMutableString *string_param = [NSMutableString stringWithCapacity:0];
            if([nextStep isEqualToString:@"reserveOrAttend"])
            {
                int i_dic = 0;
                for(NSString *string_key in [dataDic allKeys])
                {
                    if(i_dic)
                        [string_param appendString:[NSString stringWithFormat:@"&%@",string_key]];
                    else
                        [string_param appendString:[NSString stringWithFormat:@"?%@",string_key]];
                    [string_param appendString:[NSString stringWithFormat:@"=%@",dataDic[string_key]]];
                    i_dic++;
                }
                NSString *api_string = [NSString stringWithFormat:@"%@/wanyogaAdmin/ajaxMemberReserveOrAttend.rmt%@",API_NN,string_param];
                NSLog(@"%@",api_string);
                [[NNManager sharedInterface]GET:api_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
//                    [SVProgressHUD dismiss];
                    if([responseObject[@"success"]boolValue])
                    {
                        NSString *msgString = [NSString stringWithFormat:@"%@,%@,%@",responseObject[@"msg"],responseObject[@"lession"],responseObject[@"seatNo"]];
                        [SVProgressHUD showSuccessWithStatus:msgString duration:1];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:responseObject[@"msg"] duration:1];
                    }
                    [reader dismissViewControllerAnimated:YES completion:nil];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [SVProgressHUD showErrorWithStatus:[error description] duration:1];
                }];
            }
            else if([nextStep isEqualToString:@"chooseProduct"]){//选择产品
                [SVProgressHUD dismiss];
                selectViewController.type_n = YES;
                selectViewController.tableViewList = responseObject[@"products"];
                [self.navigationController pushViewController:selectViewController animated:NO];

            }
            else if([nextStep isEqualToString:@"chooseGroup"]){//选择班级
                [SVProgressHUD dismiss];
                selectViewController.type_n = NO;
                selectViewController.tableViewList = responseObject[@"groups"];
                [self.navigationController pushViewController:selectViewController animated:NO];

            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"] duration:1];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error description] duration:1];
    }];

    
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)reader

{
    //清除原有控件
    
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
        }
    }
//    添加自定义
    [self.scanView setFrame:self.view.frame];
    [reader.view addSubview:self.scanView];
//    [reader.view setFrame:self.view.frame];
    
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

- (IBAction)cancelButtonPressed:(id)sender {
    [self.timer setFireDate:[NSDate distantFuture]];
    [self dismissModalViewControllerAnimated: YES];
}
@end
