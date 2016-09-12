//
//  JGReflectionView.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGReflectionView.h"

@implementation JGReflectionView

//返回当前layer的类型
+ (Class)layerClass {
    return [CAReplicatorLayer class];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
