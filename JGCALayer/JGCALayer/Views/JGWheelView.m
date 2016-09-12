//
//  JGWheelView.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGWheelView.h"
#import "JGWheelsBtn.h"


@interface JGWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *ContentV;

@property(nonatomic,weak)JGWheelsBtn *preBtn;

@property(nonatomic,strong) CADisplayLink *link;

@end


@implementation JGWheelView

- (CADisplayLink *)link {
    
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(upDate)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return _link;
}

- (void)upDate {
    
    //让转盘开始旋转
    self.ContentV.transform = CGAffineTransformRotate(self.ContentV.transform, M_PI / 200.0);
}

//开始旋转
-(void)start {
    
    self.link.paused = NO;
}
//暂停旋转
- (void)stop {
    
    self.link.paused = YES;
}

//开始选号
- (IBAction)startChoose:(UIButton *)sender {
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 3);
    anim.duration = 1;
    [self.ContentV.layer addAnimation:anim forKey:nil];
}


//快速创建一个WheelView
+(instancetype)wheelsView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"JGWheelView" owner:nil options:nil] lastObject];
        //添加按钮
        [self setUp];
    }
    return self;
  
}


- (void)setUp {
    
    self.ContentV.userInteractionEnabled = YES;
    
    //创建按钮
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    CGFloat angle = 0;
    
    //加载原始图片
    UIImage *orgImg = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *oriSelImg = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    //获取当前屏幕与像素坐标的比例
    CGFloat scale = [UIScreen mainScreen].scale * 1.0f;
    
//    NSLog(@"==========  %f == %@",scale, NSStringFromCGSize(orgImg.size));
    
    
    CGFloat clipW = orgImg.size.width / 12 * scale;
    CGFloat clipH = orgImg.size.height * scale;
    CGFloat clipX = 0;
    CGFloat clipY = 0;

    
    for (int i = 0; i < 12; i++) {
        
        JGWheelsBtn *btn = [JGWheelsBtn buttonWithType:UIButtonTypeCustom];
        //设置按钮的尺寸
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        
        //裁剪图片当中的某一块区域
        clipX = i * clipW;
        CGRect rect = CGRectMake(clipX, clipY, clipW, clipH);
        
//        NSLog(@"8888888     %@",NSStringFromCGRect(rect));
        
        //裁剪正常状态下的图片
        CGImageRef clipImage = CGImageCreateWithImageInRect(orgImg.CGImage, rect);
        //裁剪选中状态下的图片
        CGImageRef clipSelImage = CGImageCreateWithImageInRect(oriSelImg.CGImage, rect);
        
//        btn.backgroundColor = [UIColor greenColor];
        
        //设置按钮的图片
        //把CGImageRef转成UIImage
        UIImage *clipNewImage = [UIImage imageWithCGImage:clipImage];
        [btn setImage:clipNewImage forState:UIControlStateNormal];
        
        //设置选中状态下的图片
        UIImage *clipSelNewImage = [UIImage imageWithCGImage:clipSelImage];
        [btn setImage:clipSelNewImage forState:UIControlStateSelected];
        
        //设置选中的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加按钮
        [self.ContentV addSubview:btn];
        
        //让每个按钮进行旋转
        btn.transform = CGAffineTransformMakeRotation(angle / 180.0 * M_PI);
        angle += 30;
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

//当按钮点击的时候调用
- (void)btnClick:(JGWheelsBtn *)btn {
    
    //让上一个选中按钮取消选中的状态
    self.preBtn.selected = NO;
    //让当前选中的按钮成为选中状态.
    btn.selected = YES;
    //把当前的按钮赋值给上一个按钮
    self.preBtn = btn;
}


@end
