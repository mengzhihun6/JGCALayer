//
//  JGBageValue.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGBageValue.h"
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

@interface JGBageValue ()

@property (nonatomic, weak) UIView *smallCircle;
@property (nonatomic, weak) CAShapeLayer *shap;




@end

@implementation JGBageValue

- (CAShapeLayer *)shap {
    if (!_shap) {
        //创建形状图层
        CAShapeLayer *shap = [CAShapeLayer layer];
        //设置形状的填充颜色
        shap.fillColor = [UIColor redColor].CGColor;
        _shap = shap;
        [self.superview.layer insertSublayer:shap atIndex:0];
    }
    return _shap;
}

- (void)awakeFromNib {
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}


//初始化
- (void)setUp {
  
    //设置圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    //设置字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    //设置背景颜色
    [self setBackgroundColor:[UIColor redColor]];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //添加小圆
    UIView *smallCircle = [[UIView alloc] initWithFrame:self.bounds];
    smallCircle.center = CGPointMake(kDeviceWidth * 0.5, kDeviceHight * 0.5);
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    smallCircle.backgroundColor = self.backgroundColor;
    self.smallCircle = smallCircle;
//    NSLog(@"%@", [self.superview class]);
    
    [self.superview insertSubview:smallCircle belowSubview:self];

}

//当手指开始拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //当前移动的偏移量
    CGPoint tranP = [pan translationInView:self];
    
    CGPoint center = self.center;
    center.x += tranP.x;
    center.y += tranP.y;
    self.center = center;
    
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat disatnce = [self distanceWithSmallCircle:self.smallCircle bigCircle:self];
    
    //取出小圆半径
    CGFloat redius = self.bounds.size.width * 0.5;
    redius = redius - disatnce / 10;
    //重新设置小圆的宽高
    self.smallCircle.bounds = CGRectMake(0, 0, redius * 2, redius * 2);
    self.smallCircle.layer.cornerRadius = redius;
    
    if (self.smallCircle.hidden == NO) {
        
        //返回一个不规则的路径
        UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle bigCircle:self];
        //把路径转换成图形
        self.shap.path = path.CGPath;
    }
    
    if (disatnce > 60) {
        self.smallCircle.hidden = YES;
        [self.shap removeFromSuperlayer];
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (disatnce < 60) {
            [self.shap removeFromSuperlayer];
            self.center = self.smallCircle.center;
            self.smallCircle.hidden = NO;
        }else {
            
            //播放一个动画
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
            for (int i = 0; i < 8; i++) {
                
                NSString *imageName = [NSString stringWithFormat:@"%d",i+1];
                UIImage *image = [UIImage imageNamed:imageName];
                [imageArray addObject:image];
                
            }
            
            imageV.animationImages = imageArray;
            [imageV setAnimationDuration:1.0f];
            [imageV startAnimating];
            [self addSubview:imageV];
            
            //消失
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
            });
        }
    }
}

//计算两圆之间的距离
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bigCircle {
    
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    
    return sqrtf(offsetX * offsetX + offsetY * offsetY);
}

//根据两个圆描述一个不规则路径
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bigCircle {
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat x2 = bigCircle.center.x;
    
    CGFloat y1 = smallCircle.center.y;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle bigCircle:bigCircle];
    
    
    CGFloat cosΘ = (y2 - y1) / d;
    CGFloat sinΘ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosΘ, y1 + r1 * sinΘ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosΘ, y1 - r1 * sinΘ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosΘ, y2 - r2 * sinΘ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosΘ, y2 + r2 * sinΘ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinΘ, pointA.y + d * 0.5 * cosΘ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinΘ, pointB.y + d * 0.5 * cosΘ);
    
    //描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC（曲线）
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
