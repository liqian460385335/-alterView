//
//  LqkinAlterViewControll.m
//  LqkinAlterView
//
//  Created by 微我网络 on 15/6/30.
//  Copyright (c) 2015年 lamcelot. All rights reserved.
//

#import "LqkinAlterViewControll.h"
#import "Common.h"
#import "UIColor+Hex.h"
@interface LqkinAlterViewControll ()
{
    UIView *_view;
    CGPoint _point;
    NSTimer *_timer;
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    NSInteger _index;
}
@property (nonatomic,strong)NSArray *array;
@end
@implementation LqkinAlterViewControll

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.windowLevel = UIWindowLevelAlert;
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
    
}

#pragma mark - 懒加载
- (NSArray *)array {
    if (!_array) {
        _array = [[NSArray alloc]initWithObjects:@"确定",@"返回", nil];
    }
    return _array;
}
- (void)showMsg:(NSString *)msg
{
    //背景颜色的设置
    UIView *backGroundView = [[UIView alloc]initWithFrame:self.bounds];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.3;
    [self addSubview:backGroundView];
    
    //
    _view = [[UIView alloc]init];
    _view.bounds = CGRectMake(0, 0,self.alterWidth,self.alterHeight);
    _view.layer.cornerRadius = 5;
    _view.clipsToBounds = YES;
    _view.backgroundColor = [UIColor whiteColor];
    _view.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    _point = _view.center;
    
    //信息提示语言
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, (CGRectGetHeight(_view.bounds) - 46-40) / 2, CGRectGetWidth(_view.frame)-40, 40)];
    _label.numberOfLines = 2;
    _label.text = msg;
    _label.font = [UIFont systemFontOfSize:12];
    [_view addSubview:_label];
    
    [self creatButtonView];
    [self addSubview:_view];
    [self makeKeyAndVisible];
}

/**
 *  按钮点击(确定and取消)
 */
- (void)creatButtonView {
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_view.frame)-46, CGRectGetWidth(_view.bounds), 30)];
    [_view addSubview:buttonView];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_view.frame)/2 * i, 5, CGRectGetWidth(_view.bounds)/2, 30)];
        [button setTitle:self.array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"118dcd"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [buttonView addSubview:button];
    }
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(_view.bounds)-20, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.alpha = 0.3;
    [buttonView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_view.bounds)/2, 0,1, 40)];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.alpha = 0.3;
    [buttonView addSubview:line2];
}

/**
 *  showSimple
 */

- (void)showSimpleWithMsg:(NSString *)msg {
    UIView *backGroundView = [[UIView alloc]initWithFrame:self.bounds];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.3;
    [self addSubview:backGroundView];
    
    _view = [[UIView alloc]init];
    _view.bounds = CGRectMake(0, 0,self.alterWidth,self.alterHeight);
    _view.layer.cornerRadius = 5;
    _view.clipsToBounds = YES;
    _view.backgroundColor = [UIColor whiteColor];
    _view.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    _point = _view.center;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, (CGRectGetHeight(_view.bounds) - 46-40) / 2, CGRectGetWidth(_view.frame)-40, 40)];
    _label.numberOfLines = 2;
    _label.text = msg;
    _label.font = [UIFont systemFontOfSize:12];
    [_view addSubview:_label];
    
    [self creatButtonOnly];
    [self addSubview:_view];
    [self makeKeyAndVisible];
}

- (void)creatButtonOnly {
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_view.frame)-40, CGRectGetWidth(_view.bounds), 30)];
    [_view addSubview:buttonView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, CGRectGetWidth(_view.bounds), 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[Common colorWithGreen] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_view.bounds), 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.alpha = 0.3;
    [buttonView addSubview:line1];
}

/**
 *  单个按钮
 */
- (void)buttonPressed {
    [self hidenView];
}
#pragma mark - 事件监听
/**
 *  确定取消
 *
 *  @param sender 确定or取消
 */
- (void)buttonPressed:(UIButton *)sender {
    NSInteger index = sender.tag -100;
    if (_Block) {
        _Block(index);
    }
    [self hidenView];
}
/**
 *  隐藏view
 */
- (void)hidenView {
    self.hidden = YES;
    [_view removeFromSuperview];
}
@end
