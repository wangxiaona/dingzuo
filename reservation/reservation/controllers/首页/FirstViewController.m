//
//  FirstViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/15.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setCustomizeBackBar];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
}
- (IBAction)verifyListButtonPressed:(id)sender {
}
- (IBAction)verifyButtonPressed:(id)sender {
}
- (IBAction)scanButtonPressed:(id)sender {
}
- (IBAction)timetableButtonPressed:(id)sender {
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
