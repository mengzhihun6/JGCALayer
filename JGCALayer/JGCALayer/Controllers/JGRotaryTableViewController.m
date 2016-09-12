//
//  JGRotaryTableViewController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGRotaryTableViewController.h"
#import "JGWheelView.h"


@interface JGRotaryTableViewController ()

@property (nonatomic, weak) JGWheelView *wheels;

@end

@implementation JGRotaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JGWheelView *wheels = [JGWheelView wheelsView];
    wheels.center = self.view.center;
    self.wheels = wheels;
    [self.view addSubview:wheels];   
    
}

- (IBAction)startBtnClick:(UIButton *)sender {
    [self.wheels start];
}

- (IBAction)stopBtnClick:(UIButton *)sender {
    [self.wheels stop];
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
