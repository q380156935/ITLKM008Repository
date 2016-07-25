//
//  TwoViewController.m
//  BlockDemo
//
//  Created by 于苗 on 16/7/6.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property (nonatomic,copy)void(^myBlock)(void);

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    遇到用属性描述的block块的时候在这个block块里面一定要切记不能够使用self关键词否则会引起循环的问题导致这个界面释放不掉
//    解决的方法就是把这个self变成一个局部变量并且用__block修饰
   __block TwoViewController *safeSelf = self;
    self.myBlock = ^{
      
        [safeSelf myTest];
    };
    self.myBlock();
    
}

-(void)myTest{
    NSLog(@"这个是第二个界面的方法");
}


- (IBAction)backBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc{
    NSLog(@"第二个界面被释放了");
    [super dealloc];
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
