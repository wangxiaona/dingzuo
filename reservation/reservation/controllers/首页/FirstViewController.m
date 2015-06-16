//
//  FirstViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/15.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "FirstViewController.h"
#import "ZBarSDK.h"

@interface FirstViewController ()<ZBarReaderDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setCustomizeBackBar];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
    self.pointView.layer.cornerRadius = 4.0f;
    self.pointView.layer.masksToBounds = YES;
    
}
- (IBAction)verifyListButtonPressed:(id)sender {
}
- (IBAction)verifyButtonPressed:(id)sender {
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
    [self presentViewController:reader animated:YES completion:nil];
    
}
-(void)animations_nn
{
    self.pointView.hidden  = self.pointView.hidden?NO:YES;
}

- (IBAction)timetableButtonPressed:(id)sender {
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
    [reader.view addSubview:self.scanView];
    
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
    [self dismissModalViewControllerAnimated: YES];
}
@end
