//
//  ViewController.m
//  BlockDemo
//
//  Created by 于苗 on 16/7/6.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "TwoViewController.h"

@interface ViewController ()

@property (nonatomic,assign)NSInteger age;

@property (nonatomic,copy)NSString *str;

@property (nonatomic,retain)People *p2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    局部的非对象类型在block里面使用要注意地方
//    如果这个block块没有带参数在实现这个block的时候等号右边的那个参数可以省略
    __block int a = 20;
//    非对象类型的局部变量在block里面使用的时候block块会拷贝一份所以导致出现下面两个输出不一样，不能够在block块中直接修改这个局部变量的值，如果你要是想修改在这个局部变量的前面加一个__Block来修饰
    void(^myBlock)(void)=^{
        a = 45;
        NSLog(@"---->>>>%d",a);
    };
    a = 30;
    NSLog(@"---->>>%d",a);
    myBlock();
//    非对象类型全局的变量在block里面使用的情况
//    非对象类型的全局变量在block块里面使用没有被copy一份，所以两次输出是一样的。
    _age = 33;
    void(^myBlock2)(void)=^{
        NSLog(@"==age==>>%ld",_age);
    };
    _age = 44;
    NSLog(@"--外面的age----》》%ld",_age);
    myBlock2();
//    对象类型的局部变量在block里面使用情况,这种情况也是会copy一份,也不能直接去改变他的值想要改变要在前面加一个__block
    NSString *name=@"小明";
    void(^myBlock3)(void)=^{
//        name = @"dasd";
        NSLog(@"--name-->%@",name);
    };
    name = @"小红";
    NSLog(@"--name--->>>%@",name);
    myBlock3();
//   对象类型的全局变量在block里面使用情况
    _str = @"aaa";
    void(^myBlock4)(void)=^{
        NSLog(@"--str-->>%@",_str);
    };
    _str = @"ccc";
    NSLog(@"---str---%@",_str);
    myBlock4();
//针对上面的情况可以看出局部变量在block块中会copy一份，直接修改他的值得时候要在前面加一个__block。全局变量在block里面使用的时候不会copy一分可以直接修改他的值。
//自定义类型的局部变量在block块中的使用情况
//    自定义的局部变量不能直接在block块中去改变他的值但是可以直接改变他的属性的值。
    People *p = [[People alloc]init];
    p.userAge = 11;
    p.userName = @"123";
    void(^myBlock5)(void)=^{
       
//        p = [[People alloc]init];
        p.userName = @"123444";
        
    };
    myBlock5();
//  自定义类型的全局变量在block里面使用情况
    _p2 = [[People alloc]init];
    _p2.userName = @"abc";
    _p2.userAge = 111;
    void(^myBlock6)(void)=^{
        _p2 = [[People alloc]init];
    };
    myBlock6();
    
    
    
    
    
}
- (IBAction)goToTwoVC:(id)sender {
    
    TwoViewController *twoVC = [[TwoViewController alloc]init];
    [self presentViewController:twoVC animated:YES completion:nil];
    [twoVC release];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
