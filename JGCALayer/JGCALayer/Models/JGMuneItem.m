//
//  JGMuneItem.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMuneItem.h"

@implementation JGMuneItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image {
    
    JGMuneItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    return item;
}



@end
