//
//  Common.m
//  微他
//
//  Created by 微他 on 14-8-5.
//  Copyright (c) 2014年 微他. All rights reserved.
//

#import "Common.h"
#import "SGInfoAlert.h"
#import "AppDelegate.h"

#import "UIColor+Hex.h"
//描边粗细
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define strokeHeight 0.5
#define LABEL_TEXT_16COLOR @"595757"
static NSMutableDictionary *avatarupdate;

NSString * const GROUP_ADDRESS = @"http://waitta.com/g/@d";
@implementation Common

+ (NSString *)implode:(NSObject *)data separator:(NSString *)separator
{
    if (data == nil) {
        return nil;
    }
    NSMutableString *string = [NSMutableString string];
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *arrTemp=(NSArray *)data;
        BOOL flag = false;
        for (int i=0; i<arrTemp.count; i++) {
            if (flag) {
                [string appendFormat:@"%@",separator];
            }else{
                flag = true;
            }
            [string appendFormat:@"%@",arrTemp[i]];
        }
    }else if ([data isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dic = (NSDictionary *)data;
        BOOL flag = false;
        NSArray *allkeys = [dic allKeys];
        for (int i=0; i<allkeys.count; i++) {
            if (flag) {
                [string appendFormat:@"%@",separator];
            }else{
                flag = true;
            }
            [string appendFormat:@"%@",allkeys[i]];
        }
    }else if ([data isKindOfClass:[NSSet class]]){
        NSSet *set = (NSSet *)data;
        BOOL flag = false;
        NSEnumerator * enumerator = [set objectEnumerator];
        NSString *str;
        while (str = [enumerator nextObject]) {
            if (flag) {
                [string appendFormat:@"%@",separator];
            }else{
                flag = true;
            }
            [string appendFormat:@"%@",str];
        }
    }else
    {
        string = [NSMutableString stringWithFormat:@"%@",data];
    }
    return string;
}

+ (void)doInMainThread:(dispatch_block_t) block
{
    dispatch_async(dispatch_get_main_queue()
                   , block);
}

+ (void)tip:(NSString *)string
{
    [Common doInMainThread:^{
        
        [SGInfoAlert showInfo:string
                      bgColor:[[UIColor whiteColor] CGColor]
                       inView:((AppDelegate *)[UIApplication sharedApplication].delegate).window
                     vertical:0.85];
    }];
}

+ (NSString *)timeIntervalSince1970:(NSString *)dateline
{
    NSInteger date = [[NSDate date] timeIntervalSince1970] - [dateline integerValue];
    if (date > 31536000) {
        return [NSString stringWithFormat:@"%ld年前",date / 31536000];
    }else if (date > 86400){
        return [NSString stringWithFormat:@"%ld天前",date / 86400];
    }else if (date > 3600){
        return [NSString stringWithFormat:@"%ld小时前",date / 3600];
    }else if (date > 60){
        return [NSString stringWithFormat:@"%ld分前",date / 60];
    }else if (date > 0){
        return [NSString stringWithFormat:@"%ld秒前",(long)date];
    }else{
        return [NSString stringWithFormat:@"现在"];
    }
}

+ (NSString *)dateWithTimeIntervalSince1970:(NSString *)dateline
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSInteger date = [[NSDate date] timeIntervalSince1970] - [dateline integerValue];
    [formatter setDateFormat:@"MM月dd日"];
    if (date < 86400) {
        [formatter setDateFormat:@"hh:mm"];
    }
    NSString *dateLoca = [NSString stringWithFormat:@"%@",dateline];
    NSTimeInterval time= [dateLoca doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:detaildate];
}

+ (NSDictionary *) parseJsonData:(NSData *)data
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error != nil){
        NSLog(@"反序列化时发生一个错误");
    }
    return json;
}

+ (NSDictionary *)stringtoDic:(NSString *)msgStr{
    NSData *data = [msgStr dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

//+ (NSDictionary *)getDateline:(NSString *)dateline
//{
//    [avatarupdate removeAllObjects];
//    avatarupdate = nil;
//    avatarupdate = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dateline,[NSString stringWithFormat:@"%ld",(long)[User_member instance].uid], nil];
//    return avatarupdate;
//}

+(NSDictionary *)getappinfo
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    return infoDict;
}

+ (CGSize)autoSizeWithString:(NSString *)string
                    fontSize:(CGFloat)fontSize {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(260, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil].size;
    return size;
}


+ (UIView *)strokeView:(UIView *)view
{
    view = [self strokeView:view header:YES footer:YES];
    return view;
}

+ (UIView *)strokeView:(UIView*)view header:(BOOL)header footer:(BOOL)footer
{
    CGFloat height = strokeHeight;
    //头部描边
    if (header) {
        UIView *headerStroke = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, height)];
//        headerStroke.backgroundColor = [SetFontColorProperty setCostomColor:CustomStrokeColor];
        headerStroke.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [view addSubview:headerStroke];
    }
    //尾部描边
    if (footer) {
        UIView *footerStroke = [[UIView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - height, view.bounds.size.width, height)];
//        footerStroke.backgroundColor = [SetFontColorProperty setCostomColor:CustomStrokeColor];
        footerStroke.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [view addSubview:footerStroke];
    }
    return view;
}

+ ( int )countTheStrLength:( NSString *)strtemp {
    
    int strlength = 0 ;
    
    char * p = ( char *)[strtemp cStringUsingEncoding : NSUnicodeStringEncoding ];
    
    for ( int i= 0 ; i<[strtemp lengthOfBytesUsingEncoding : NSUnicodeStringEncoding ] ;i++) {
        
        if (*p) {
            
            p++;
            
            strlength++;
            
        }
        
        else {
            
            p++;
            
        }
        
    }
    
    return (strlength+ 1 )/ 2 ;
    
}

+ (NSString *)upchanggemyrole:(NSString *)role
{
    if ([role isEqualToString:@"0"]) {
        role = @"1";
        return role;
    }else
        if ([role isEqualToString:@"0.5"]) {
            role = @"2";
            return role;
        }
    if ([role isEqualToString:@"1"]) {
        role = @"3";
        return role;
    }
    if ([role isEqualToString:@"其他"]) {
        role = @"0";
        return role;
    }
    return nil;
}

+ (NSString *)requestchanggemyrole:(NSString *)role
{
    if ([role integerValue] == 0) {
        role = @"其他";
        return role;
    }
    if ([role integerValue] == 1) {
        role = @"0";
        return role;
    }
    if ([role integerValue] == 2) {
        role = @"0.5";
        return role;
    }
    if ([role integerValue] == 3) {
        role = @"1";
        return role;
    }
    return nil;
}


+ (NSString *)conversionTime:(CommonType)commomType dateline:(NSString *)dateline
{
    switch (commomType) {
        case 0:
            return [self conversion:@"YYYY年MM月dd日" dateline:dateline];
            break;
        case 1:
            return [self conversion:@"MM月dd日" dateline:dateline];
            break;
        case 2:
            return [self conversion:@"hh:mm" dateline:dateline];
            break;
        case 3:
            return [self conversion:@"MM-dd hh:mm" dateline:dateline];
            break;
        default:
            break;
    }
}

+ (NSString *)conversion:(NSString *)str dateline:(NSString *)dateline
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:str];
    NSTimeInterval time = [dateline doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:date];
}

+ (void)verificationCode:(void(^)())blockYes blockNo:(void(^)(id time))blockNo {
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                blockYes();
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                blockNo(strTime);
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

+ (UIColor *)labelTextColor_HUI {
    return [UIColor colorWithHexString:LABEL_TEXT_16COLOR];;
}

+ (UIColor *)colorWithGreen {
    return [UIColor colorWithHexString:@"33ccbf"];
}
+ (void)tipForDown:(NSString *)string {
    [Common doInMainThread:^{
 
        [SGInfoAlert showInFordown:string
                           bgColor:[[UIColor whiteColor] CGColor]
                            inView:((AppDelegate *)[UIApplication sharedApplication].delegate).window
                          vertical:0.85];
    }];
}

+ (void)setNSUserDefaults:(NSString *)string {
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (NSString *)getNSUserDefaults:(NSString *)string {
    return [[NSUserDefaults standardUserDefaults]objectForKey:string];
}
+ (void)deleteNSUserDefaults:(NSString *)string {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - 压缩图片
#pragma mark image scale utility

#pragma mark - 字体大小

+ (UIFont *)fontWithScreen:(NSInteger)font {
    NSInteger font1 = font * ScreenHeight * 0.0018;
    UIFont *newFont = [UIFont systemFontOfSize:font1];
    
    return newFont;
}
+ (UIFont *)fontWithScreenWithBlod:(NSInteger)font {
    
    NSInteger font1 = font * ScreenHeight * 0.0018;
    UIFont *newFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:font1];
    
    return newFont;
}

+ (UIColor *)colorWithGray {
    return [UIColor colorWithHexString:@"e5e5e5"];
}
//pick分割线
+ (UIColor *)lineWithGray {
    return [UIColor colorWithHexString:@"cac8c8"];
}

//灰色c8c8c8//自定义alpha
+ (UIColor *)lqkinLineWithGray:(NSString *)coloer alpha:(CGFloat)alpgha
{
    return [UIColor colorWithHexString:coloer alph:alpgha];
}
+(UIView *)line:(CGRect)frame {
    UIView *line = [[UIView alloc]initWithFrame:frame];
    line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    return line;
}
+(void)lineForView:(UIView *)view {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame)-1, ScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [view addSubview:line];
}


@end
