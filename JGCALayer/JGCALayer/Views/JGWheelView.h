//
//  JGWheelView.h
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGWheelView : UIView

//快速创建一个WheelView
+(instancetype)wheelsView;


//开始旋转
-(void)start;
//暂停旋转
- (void)stop;

@end
