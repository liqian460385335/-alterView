//
//  ViewController.m
//  LqkinAlterView
//
//  Created by 微我网络 on 15/6/30.
//  Copyright (c) 2015年 lamcelot. All rights reserved.
//

#import "ViewController.h"
#import "LqkinAlterViewControll.h"
#import "UIColor+Hex.h"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕适配
#define IPHONE4 ScreenHeight == 480
#define IPHONE5 ScreenHeight == 568
#define IPHONE6 ScreenHeight == 667
//定义比例
#define PRO ScreenWidth / 320.0
@interface ViewController ()
@property (nonatomic,strong)LqkinAlterViewControll * lqkinalter;
@property (nonatomic,strong)UIButton * btton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _btton = [UIButton buttonWithType:UIButtonTypeCustom];
    _btton.frame = CGRectMake(100, 100, 80, 40);
    [_btton setTitle:@"点击点击" forState:UIControlStateNormal];
    [_btton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btton addTarget:self action:@selector(processClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btton];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)processClick
{
    _lqkinalter = [[LqkinAlterViewControll alloc]init];
    //修改提示款的大小
    _lqkinalter.alterWidth = 230.5*PRO;
    _lqkinalter.alterHeight = 94*PRO;
    [_lqkinalter showMsg:@"欢迎光临"];
    
    [_lqkinalter setBlock:^(NSInteger index) {
       
        NSLog(@"%d",index);
        
    }];
//    [_lqkinalter showSimpleWithMsg:@"哈哈"];
}


@end
