//
//  JGWheelsBtn.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGWheelsBtn.h"

@implementation JGWheelsBtn

//返回按钮当中的UIImageView的尺寸位置
//contentRect:当前按钮的尺寸位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat w = 40;
    CGFloat h = 50;
    CGFloat x = (contentRect.size.width - w) * 0.5;
    CGFloat y = 20;
    return CGRectMake(x, y, w, h);
}

//取消按钮高亮状态下做的事情
- (void)setHighlighted:(BOOL)highlighted {
    
}


@end
