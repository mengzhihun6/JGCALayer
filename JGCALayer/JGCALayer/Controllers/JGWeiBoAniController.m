//
//  JGWeiBoAniController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGWeiBoAniController.h"
#import "JGWeiBoComposeController.h"
#import "JGMuneItem.h"



@interface JGWeiBoAniController ()

@end

@implementation JGWeiBoAniController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnClick:(UIButton *)sender {
    
    
    JGWeiBoComposeController *vc = [[JGWeiBoComposeController alloc] init];
    
    
    JGMuneItem *item = [JGMuneItem itemWithTitle:@"点评" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    JGMuneItem *item1 = [JGMuneItem itemWithTitle:@"更多" image:[UIImage imageNamed:@"tabbar_compose_more"]];
    JGMuneItem *item2 = [JGMuneItem itemWithTitle:@"拍摄" image:[UIImage imageNamed:@"tabbar_compose_camera"]];
    JGMuneItem *item3 = [JGMuneItem itemWithTitle:@"相册" image:[UIImage imageNamed:@"tabbar_compose_photo"]];
    JGMuneItem *item4 = [JGMuneItem itemWithTitle:@"文字" image:[UIImage imageNamed:@"tabbar_compose_idea"]];
    JGMuneItem *item5 = [JGMuneItem itemWithTitle:@"签到" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    
    vc.itemArray = @[item,item1,item2,item3,item4,item5];
    
    [self presentViewController:vc animated:YES completion:nil];
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
