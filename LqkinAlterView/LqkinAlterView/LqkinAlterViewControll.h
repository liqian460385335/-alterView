//
//  LqkinAlterViewControll.h
//  LqkinAlterView
//
//  Created by 微我网络 on 15/6/30.
//  Copyright (c) 2015年 lamcelot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LqkinAlterViewControll : UIWindow
- (void)showMsg:(NSString *)msg;//正常
/**
 *  showSimple
 */

- (void)showSimpleWithMsg:(NSString *)msg;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,copy) void(^Block)(NSInteger index);//付款

@property (nonatomic,assign)CGFloat alterWidth;//宽度
@property (nonatomic,assign)CGFloat alterHeight;//高度
@end
