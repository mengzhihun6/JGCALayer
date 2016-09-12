//
//  JGMosaicView.h
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGMosaicView : UIView

/**
 要刮的底图.
 */
@property (nonatomic, strong) UIImage *image;
/**
 涂层图片.
 */
@property (nonatomic, strong) UIImage *surfaceImage;

/** 模糊区域大小 */
@property (nonatomic, assign) CGFloat mosaicValue;

@end
