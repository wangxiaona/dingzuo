//
//  BindViewController.m
//  reservation
//
//  Created by 王晓娜 on 15/6/16.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "SubCateViewController.h"
#import "BindViewController.h"

@interface SubCateViewController ()
{
    NSIndexPath *index_nn;
}
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@end

@implementation SubCateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = 44*4;
    self.view.frame = viewFrame;
    [self.button1 addTarget:self.bindVc action:@selector(subCateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self.bindVc action:@selector(subCateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self.bindVc action:@selector(subCateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self.bindVc action:@selector(subCateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.lastButton = self.button1;
    self.lastButton.selected = YES;
}

#pragma mark - Table view data source



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
