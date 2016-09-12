//
//  JGHeartBeatAndTranstionController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGHeartBeatAndTranstionController.h"

@interface JGHeartBeatAndTranstionController ()

@property (weak, nonatomic) IBOutlet UIImageView *heartImageV;

@property (weak, nonatomic) IBOutlet UIImageView *picImageV;


@end


static int _i = 1;

@implementation JGHeartBeatAndTranstionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self CATransition];
    
}

- (void)CATransition {
    
    //转场代码必须和转场动画在同一个方法中
    //创建动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
    anim.type = @"pageCurl";
    //设置转场方向
    anim.subtype = kCATransitionFromTop;
    //设置动画的开始点
    anim.startProgress = 0.2;
    //设置动画的结束点
    anim.endProgress = 0.8;
    
    anim.duration = 1;
    [self.picImageV.layer addAnimation:anim forKey:nil];
    
    //转场代码
    _i++;
    if (_i > 3) {
        _i = 1;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%d",_i];
    self.picImageV.image = [UIImage imageNamed:imageName];
}


//转场
- (IBAction)transitionBtnClick:(UIButton *)sender {
    
    [UIView transitionWithView:self.picImageV duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        _i++;
        if (_i > 3) {
            _i = 1;
        }
        NSString *imageName = [NSString stringWithFormat:@"%d",_i];
        self.picImageV.image = [UIImage imageNamed:imageName];
    } completion:nil];
}

//心跳
- (IBAction)heartBeatBtnClick:(UIButton *)sender {
    
    //创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置属性
    anim.keyPath = @"transform.scale";
    //设置属性值
    anim.toValue = @0;
    //设置动画的执行次数
    anim.repeatCount = MAXFLOAT;
    //设置动画的执行时长
    anim.duration = 0.5;
    
    //自动反转
    anim.autoreverses = YES;
    //添加动画
    [self.heartImageV.layer addAnimation:anim forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
