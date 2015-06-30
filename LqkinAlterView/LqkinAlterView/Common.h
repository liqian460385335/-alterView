//
//  Common.h
//  微他
//
//  Created by 微他 on 14-8-5.
//  Copyright (c) 2014年 微他. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CommonType)
{
    CommonTypeYYYYMMdd,//年月日
    CommonTypeMMdd,//月日
    CommonTypehhmm,//小时分
    CommonTypeMMddhhmm,//月-日 时-分
};

extern  NSString * const GROUP_ADDRESS;

@interface Common : NSObject

+ (NSString *)getDateline:(NSString *)dateline;
+ (NSString *)implode:(NSObject *)data separator:(NSString *)separator;

+ (void)doInMainThread:(dispatch_block_t) block;
+ (void)tip:(NSString *)string;
+ (NSString *)timeIntervalSince1970:(NSString *)dateline;//转换时间
+ (NSString *)dateWithTimeIntervalSince1970:(NSString *)dateline;
+ (NSString *)conversionTime:(CommonType)commomType dateline:(NSString *)dateline;
+ (NSDictionary *) parseJsonData:(NSData *)data;

+ ( int )countTheStrLength:( NSString *)strtemp;//计算字符长度

+ (NSDictionary *)stringtoDic:(NSString *)msgStr;

//描边
+ (UIView *)strokeView:(UIView *)view;
+ (UIView *)strokeView:(UIView*)view header:(BOOL)header footer:(BOOL)footer;
+ (NSMutableDictionary *)getappinfo;
+ (CGSize)autoSizeWithString:(NSString *)string fontSize:(CGFloat)fontSize;

+ (NSString *)upchanggemyrole:(NSString *)role;//上传时改变role
+ (NSString *)requestchanggemyrole:(NSString *)role;//请求回来数据改变role

//tqh add

/**
 *  验证码倒计时
 *
 *  @param blockYes 倒计时完成
 *  @param blockNo  正在倒计时中
 */
+ (void)verificationCode:(void(^)())blockYes blockNo:(void(^)(id time))blockNo;

+ (UIColor *)labelTextColor_HUI;
//浅绿色
+ (UIColor *)colorWithGreen;
//下方弹出提示
+ (void)tipForDown:(NSString *)string;

//NSUserDefault使用
/**
 *  设置NSUserDefault
 */
+ (void)setNSUserDefaults:(NSString *)string;
/**
 *  取出NSUserDefault
 *
 *  @param string 键的名称
 *
 *  @return 字符串
 */
+ (NSString *)getNSUserDefaults:(NSString *)string;
/**
 *  删除NSUserDefault
 *
 *  @param string 键的名称
 */
+ (void)deleteNSUserDefaults:(NSString *)string;
/**
 *  压缩图片
 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

+ (UIFont *)fontWithScreen:(NSInteger)font;
+ (UIFont *)fontWithScreenWithBlod:(NSInteger)font;

//线条(浅灰色)
+(UIColor *)colorWithGray;
//pick线条
+ (UIColor *)lineWithGray;

//灰色c8c8c8//自定义alpha
+ (UIColor *)lqkinLineWithGray:(NSString *)coloer alpha:(CGFloat)alpgha;
//自定义位置
+ (UIView *)line:(CGRect)frame;
//默认位置
+(void)lineForView:(UIView *)view;


@end
