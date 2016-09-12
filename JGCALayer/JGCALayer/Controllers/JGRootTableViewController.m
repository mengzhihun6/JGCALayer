//
//  JGRootTableViewController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/11.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGRootTableViewController.h"

@interface JGRootTableViewController ()
/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString * const JGRootCellID = @"JGRootCellID";

@implementation JGRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JGRootCellID];
    
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"01 - CALayer的基本操作",
                       @"02 - 时钟效果",
                       @"03 - 心跳效果/转场动画",
                       @"04 - 转盘",
                       @"05 - 图片折叠",
                       @"06 - 音乐震动条/复制层",
                       @"07 - 倒影",
                       @"08 - 粒子效果",
                       @"09 - QQ粘性布局",
                       @"10 - 微博动画",
                       @"11 - 打马赛克"];
    }
    return _dataArray;
}





#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGRootCellID forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取出story
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //找到story中对应的控制器
    UIViewController *vc;
    if (indexPath.row == 0) { //基本操作
        
        vc = [story instantiateViewControllerWithIdentifier:@"basicVC"];
    }else if (indexPath.row == 1) {//时钟效果
        
        vc = [story instantiateViewControllerWithIdentifier:@"clockVC"];
    }else if (indexPath.row == 2) { //心跳效果/转场动画
        
        vc = [story instantiateViewControllerWithIdentifier:@"heartAndTr"];
    }else if (indexPath.row == 3) {//转盘
        
        vc = [story instantiateViewControllerWithIdentifier:@"RotaryTable"];
    }else if (indexPath.row == 4) {//图片折叠
        
        vc = [story instantiateViewControllerWithIdentifier:@"picFoldVC"];
    }else if (indexPath.row == 5) {//音乐震动条/复制层
        
        vc = [story instantiateViewControllerWithIdentifier:@"MusicVibration"];
    }else if (indexPath.row == 6) {//倒影
        
        vc = [story instantiateViewControllerWithIdentifier:@"reflectionVC"];
    }else if (indexPath.row == 7) {//粒子效果
        
        vc = [story instantiateViewControllerWithIdentifier:@"particleVC"];
    }else if (indexPath.row == 8) {//QQ粘性布局
        
        vc = [story instantiateViewControllerWithIdentifier:@"BageValueVC"];
    }else if (indexPath.row == 9) {//微博动画
        
        vc = [story instantiateViewControllerWithIdentifier:@"weiboVC"];
    }else if (indexPath.row == 10) {//打马赛克
        
        vc = [story instantiateViewControllerWithIdentifier:@"mosaicVC"];
    }
    
    //跳转
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
