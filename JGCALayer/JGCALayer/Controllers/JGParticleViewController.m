//
//  JGParticleViewController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGParticleViewController.h"
#import "JGParticleView.h"


@interface JGParticleViewController ()
@property (strong, nonatomic) IBOutlet JGParticleView *VCView;

@end

@implementation JGParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//开始
- (IBAction)start:(UIButton *)sender {
   
    [self.VCView start];
    
}


//重绘
- (IBAction)reDraw:(UIButton *)sender {
    [self.VCView reDraw];
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
