//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGInfoAlert.h"
#import "GLFontSize.h"
@implementation SGInfoAlert


// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { 
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); 
    CGContextTranslateCTM (context, CGRectGetMinX(rect), 
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); 
    fw = CGRectGetWidth (rect) / ovalWidth; 
    fh = CGRectGetHeight (rect) / ovalHeight; 
    CGContextMoveToPoint(context, fw, fh/2); 
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); 
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
    CGContextClosePath(context); 
    CGContextRestoreGState(context); 
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, 300, frame.size.height + 24);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = [[UIColor blackColor] CGColor];
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, 0.7);
    addRoundedRectToPath(context, rect, 2.0f, 2.0f);
    CGContextSetFillColorWithColor(context, bgcolor_);
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
    //    CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    float x = (rect.size.width - fontSize_.width) / 2.0;
    float y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);
    [info_ drawInRect:r withFont:[UIFont systemFontOfSize:13] lineBreakMode:NSLineBreakByClipping];
}


//- (void)dealloc{
//    [info_ release];
//    [super dealloc];
//}

// 从上层视图移除并释放
- (void)remove {
    [self removeFromSuperview];
}

// 渐变消失
- (void)fadeAway{
    [UIView animateWithDuration:1 animations:^{
           self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    self.alpha = 0;
//    [UIView commitAnimations];
//    [self performSelector:@selector(remove) withObject:nil afterDelay:1];
}

+ (void)showInfo:(NSString *)info 
         bgColor:(CGColorRef)color
          inView:(UIView *)view 
        vertical:(float)height {
    
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    
    CGSize size = [GLFontSize sizeWithString:info font:[UIFont systemFontOfSize:13.33] width:230];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, (frame.size.height + 24) / 2.0 + 68);
    alert.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 15.5, 15.5)];
    imageView.center = CGPointMake((300 - size.width) / 2 - 18, CGRectGetMidY(alert.bounds) + 1);
    
    imageView.image = [UIImage imageNamed:@"感叹号"];
    [alert addSubview:imageView];
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

+ (void)showInFordown:(NSString*)info
              bgColor:(CGColorRef)color
               inView:(UIView*)view
             vertical:(float)height {
    height = height < 0 ? 0 : height > 1 ? 1 : height;

    CGSize size = [GLFontSize sizeWithString:info font:[UIFont systemFontOfSize:13.33] width:230];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x,ScreenHeight - (frame.size.height + 24) / 2.0-10);
    alert.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 15.5, 15.5)];
    imageView.center = CGPointMake((300 - size.width) / 2 - 18, CGRectGetMidY(alert.bounds) + 1);
    
    imageView.image = [UIImage imageNamed:@"感叹号"];
    [alert addSubview:imageView];
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

@end
