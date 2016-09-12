//
//  JGMosaicView.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMosaicView.h"

@interface JGMosaicView () {
    CGFloat _record;
}

@property (nonatomic, strong) UIImageView *surfaceImageView;

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) CGMutablePathRef path;

@end



@implementation JGMosaicView


- (void)awakeFromNib {
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

//模糊区域大小
- (void)setMosaicValue:(CGFloat)mosaicValue {
    _mosaicValue = mosaicValue;
    
    if (_record == 0) {
        _record = mosaicValue;
    }
    
    if (_record != mosaicValue) return;
    //设置马赛克的模糊区域大小
    self.shapeLayer.lineWidth = (self.mosaicValue == 0) ? 10.f : self.mosaicValue;
}


- (void)setUp {

    
    //添加imageview（surfaceImageView）到self上
    self.surfaceImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.surfaceImageView];
    //添加layer（imageLayer）到self上
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.bounds;
    [self.layer addSublayer:self.imageLayer];

    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinRound;
    
//    NSLog(@"%f  --  %f ",self.mosaicValue, _mosaicValue);
    
//    self.shapeLayer.lineWidth = (self.mosaicValue == 0) ? 10.f : self.mosaicValue;
    self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    self.shapeLayer.fillColor = nil; //此处设置颜色有异常效果，可以自己试试
    
    [self.layer addSublayer:self.shapeLayer];
    self.imageLayer.mask = self.shapeLayer;
    
    self.path = CGPathCreateMutable(); 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
}

- (void)setImage:(UIImage *)image {
    //底图
    _image = image;
    self.imageLayer.contents = (__bridge id _Nullable)(image.CGImage);
}

- (void)setSurfaceImage:(UIImage *)surfaceImage {
    //顶图
    _surfaceImage = surfaceImage;
    self.surfaceImageView.image = surfaceImage;
    
}




- (void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}





@end
