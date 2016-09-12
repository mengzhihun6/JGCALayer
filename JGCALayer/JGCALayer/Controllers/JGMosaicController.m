//
//  JGMosaicController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMosaicController.h"
#import "JGMosaicView.h"
#import "UIImage+JGMosaic.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

@interface JGMosaicController ()

@property (nonatomic, strong) JGMosaicView *mosaicV;

@end

@implementation JGMosaicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createMosaic];
    
    [self createSlider];
}

- (void)createMosaic {
    
    CGFloat x = kDeviceWidth * 0.1;
    _mosaicV = [[JGMosaicView alloc] initWithFrame:CGRectMake(x, 100, kDeviceWidth - x * 2, 300)];
    UIImage *image = [UIImage imageNamed:@"阿狸头像"];
    
    //顶图
    _mosaicV.surfaceImage = image;
    //底图
    _mosaicV.image = [UIImage transToMosaicImage:image blockLevel:5];
//    _mosaicV.mosaicValue = 100;
    
    [self.view addSubview:_mosaicV];
}


- (void)createSlider {
    
    
    //左右轨的图片
    UIImage *stetchLeftTrack = [UIImage imageNamed:@"LuckyAnimal"];
    UIImage *stetchRightTrack = [UIImage imageNamed:@"LuckyAnimalPressed"];
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"coi_net"];
    
    CGFloat x = kDeviceWidth * 0.1;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(x,450,kDeviceWidth - x * 2,7)];
    slider.backgroundColor = [UIColor clearColor];
    slider.value = 0.0;
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    
    [slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [slider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //注意这里务必加上UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    //滑块拖动后的事件
    [slider addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:slider];
    
    
    
    
    
}


- (void)sliderDragUp:(UISlider *)slider {
    
//    NSLog(@"=====  %f", slider.value);
    
    _mosaicV.mosaicValue = slider.value;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
