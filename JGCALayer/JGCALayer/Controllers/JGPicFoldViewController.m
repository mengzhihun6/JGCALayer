//
//  JGPicFoldViewController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGPicFoldViewController.h"

@interface JGPicFoldViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;
@property (weak, nonatomic) IBOutlet UIView *dragView;

@property (nonatomic, weak) CAGradientLayer *gradient;

@end

@implementation JGPicFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //让上部分图片只显示上半部分
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    //让下部分图片只显示下部分
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);

    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.dragView addGestureRecognizer:pan];
    
    //给底部图片添加渐变
    //渐变层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bottomImageV.bounds;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    
    //设置不透明度
    gradient.opacity = 0;
    self.gradient = gradient;
    [self.bottomImageV.layer addSublayer:gradient];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint transP = [pan translationInView:self.dragView];
    
    CATransform3D transform = CATransform3DIdentity;
    //立体的效果， 近大远小
    transform.m34 = -1 /550.0;
    
    //设置不透明度
    CGFloat opcity = transP.y * 1 /256.0;
    self.gradient.opacity = opcity;
    
    CGFloat angle = transP.y * M_PI /256.0;
    //让上半部分做旋转
    self.topImageV.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        self.gradient.opacity = 0;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            //让上部图片反弹回去
            self.topImageV.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

//渐变层
- (void)gradientL{
    
    //渐变层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bottomImageV.bounds;
    gradient.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    
    //设置渐变的方向
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    //设置从哪个位置渐变到下一个颜色.
    gradient.locations = @[@0.2,@0.8];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
