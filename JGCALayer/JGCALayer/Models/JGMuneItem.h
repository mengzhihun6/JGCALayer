//
//  JGMuneItem.h
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JGMuneItem : NSObject

/** 图片  */
@property (nonatomic, strong) UIImage *image;
/** 标题  */
@property (nonatomic, strong)NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;


@end
