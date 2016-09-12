//
//  JGReflectionController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGReflectionController.h"

@interface JGReflectionController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation JGReflectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@",[self.view.layer class]);
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;
    repL.instanceCount = 2;
    //复制出来的子层，它都是围绕着复制层锚点进行旋转
    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    repL.instanceRedOffset -= 0.1;
    repL.instanceGreenOffset -= 0.1;
    repL.instanceBlueOffset -= 0.1;
    repL.instanceAlphaOffset -= 0.1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
