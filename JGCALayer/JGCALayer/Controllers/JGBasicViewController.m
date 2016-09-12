//
//  JGBasicViewController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGBasicViewController.h"

@interface JGBasicViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIView *cusView;

@property(nonatomic,weak)CALayer *layer;
@end

@implementation JGBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 64, 100, 100);
    layer.position = CGPointMake(100, 200);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义CALayer -
- (IBAction)CusCALayer:(UIButton *)sender {
    
    CALayer *layer = [CALayer layer];
    layer.frame = self.cusView.bounds;
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.cusView.layer addSublayer:layer];
    layer.contents = (id)[UIImage imageNamed:@"阿狸头像"].CGImage;
}


#pragma mark - 隐式动画 -
- (IBAction)implicitAnimationBtn:(UIButton *)sender {
    
    //动画底层都是包装成多个事务
    //有很多操作绑定在一起，当这些操作全部执行完毕时，它才进行下一步操作
    [CATransaction begin];
    
    //设置事务有没有动画
    [CATransaction setDisableActions:NO];
    //设置事务动画的执行时长
    [CATransaction setAnimationDuration:1.0f];
    
    self.layer.bounds = CGRectMake(100, 100, arc4random_uniform(200), arc4random_uniform(200));
    self.layer.position = CGPointMake(arc4random_uniform(300) + 100, arc4random_uniform(400) + 100);
    self.layer.backgroundColor = [self randomColor].CGColor;
    self.layer.cornerRadius = arc4random_uniform(self.layer.bounds.size.width);
    [CATransaction commit];
}

- (UIColor *)randomColor{
    
    CGFloat r = arc4random_uniform(256) /255.0;
    CGFloat g = arc4random_uniform(256) /255.0;
    CGFloat b = arc4random_uniform(256) /255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


#pragma mark - 翻转 -
- (IBAction)UIViewAni:(UIButton *)sender {
    
    [UIView animateWithDuration:1 animations:^{
        //3D
        //self.imageV.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        
        //self.imageV.layer.transform = CATransform3DMakeTranslation(100, 50, 1);
        
        //self.imageV.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0);
        
        //把结构体转成对象
        //做3d旋转的时候一般不用KVC
        //什么时候用KVC
        //做一些快速缩放,平移,二维旋转.
        //        NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
        [self.imageV.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.x"];
        
    }];
}


#pragma mark - 变圆 -
- (IBAction)UIImageVLayer:(UIButton *)sender {
    
    //UIView本身就自带阴影效果,它是透明.
    self.imageV.layer.shadowOpacity = 1;
    //设置阴影的偏移量
    self.imageV.layer.shadowOffset = CGSizeMake(-30, -10);
    //设置阴影的模糊程度
    self.imageV.layer.shadowRadius = 10;
    //设置阴影的颜色
    self.imageV.layer.shadowColor = [UIColor blueColor].CGColor;
    
    //设置边框的颜色
    self.imageV.layer.borderColor = [UIColor greenColor].CGColor;
    //设置边框的宽度
    self.imageV.layer.borderWidth = 2;
    
    //设置圆角半径.
    self.imageV.layer.cornerRadius = 50;
    
    //我们设置的所有layer的属性只作用在根层上.
    //    NSLog(@"%@",self.imageV.layer.contents);
    //超过根层以外东西都会被裁剪掉.
    self.imageV.layer.masksToBounds = YES;
}


#pragma mark - 变圆带阴影 -
- (IBAction)UIViewLayer:(UIButton *)sender {
    
    //UIView本身就自带阴影效果,它是透明.
    self.redView.layer.shadowOpacity = 1;
    //设置阴影的偏移量
    self.redView.layer.shadowOffset = CGSizeMake(-30, -10);
    //设置阴影的模糊程度
    self.redView.layer.shadowRadius = 10;
    //设置阴影的颜色
    self.redView.layer.shadowColor = [UIColor blueColor].CGColor;
    
    //设置边框的颜色
    self.redView.layer.borderColor = [UIColor greenColor].CGColor;
    //设置边框的宽度
    self.redView.layer.borderWidth = 2;
    
    //设置圆角半径.
    self.redView.layer.cornerRadius = 50;
}


@end
