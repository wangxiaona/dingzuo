//
//  FirstViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/15.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setFrame:[UIScreen mainScreen].bounds];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
    self.pointView.layer.cornerRadius = 4.0f;
    self.pointView.layer.masksToBounds = YES;
    
    userListController = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
    bindController = [[BindViewController alloc] initWithNibName:@"BindViewController" bundle:nil];
    timetableController = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
    selectViewController = [[SelectViewController alloc] initWithNibName:@"SelectViewController" bundle:nil];
    
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
    reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);
    reader.showsZBarControls=NO;
    
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
   
    
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString * api = [API_NN stringByAppendingString:@""];
    [[NNManager sharedInterface]GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        if([responseObject[@"success"]boolValue])
        {
            selectViewController.type_n = [responseObject[@"nextStep"] isEqualToString:@"chooseProduct"];
            if(selectViewController.type_n)
            {
                selectViewController.tableViewList = responseObject[@"products"];
            }
            else
            {
                selectViewController.tableViewList = responseObject[@"groups"];
            }
            [self.navigationController pushViewController:selectViewController animated:NO];
            [self presentViewController:reader animated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];

    
    
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
    [reader dismissViewControllerAnimated:YES completion:nil];
    NSString *string = symbol.data;
    NSLog(@"%@",string);
    
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
