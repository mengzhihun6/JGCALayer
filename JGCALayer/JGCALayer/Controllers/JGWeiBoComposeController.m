//
//  JGWeiBoComposeController.m
//  JGCALayer
//
//  Created by stkcctv on 16/9/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGWeiBoComposeController.h"
#import "JGMuneItem.h"
#import "JGItemBtn.h"

#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width


@interface JGWeiBoComposeController ()


@property(nonatomic,strong)NSMutableArray *btnArray;

@property(nonatomic,assign)int btnIndex;

@property(nonatomic,strong)NSTimer *timer;
@end

@implementation JGWeiBoComposeController

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //回到上一个界面按钮
    [self returnSupVC];
    
    [self addBtn];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    
}

- (void)returnSupVC {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"返回上一界面" forState:UIControlStateNormal];
    btn.center = CGPointMake(kDeviceWidth * 0.5, kDeviceHight * 0.9);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




//每隔0.1秒调用一次
- (void)update {
    
    //如果当前的角标等于当前按钮的个数
    //让定时器停止
    if (self.btnIndex == self.btnArray.count) {
        [self.timer invalidate];
        return;
    }
    
    //每次取出一个按钮
    UIButton *btn = self.btnArray[self.btnIndex];
    //取消所有形变
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    self.btnIndex++;
    
}

- (void)addBtn {
    
    CGFloat btnWH = 100;
    int cloumn = 3;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cloumn * btnWH) / (cloumn + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    int curCloumn = 0;
    int curRow = 0;
    CGFloat oriY = 300;
    
    for (int i = 0; i < self.itemArray.count; i++) {
        
        JGItemBtn *btn = [JGItemBtn buttonWithType:UIButtonTypeCustom];
        
        //当前所在的列
        curCloumn = i % cloumn;
        //当前所在的行
        curRow = i / cloumn;
        
        x = margin + (btnWH + margin) * curCloumn;
        y = oriY + (btnWH + margin) * curRow;
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        
        
        JGMuneItem *item = self.itemArray[i];
        //设置按钮图片
        [btn setImage:item.image forState:UIControlStateNormal];
        //设置按钮文字
        [btn setTitle:item.title forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        //开始时让所有按钮都移动到最底部
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        [self.btnArray addObject:btn];
        
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//当手指按下的时调用
- (void)btnClick:(UIButton *)btn {
    
    [UIView animateWithDuration:0.5f animations:^{
        
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

//当手指抬起时调用
- (void)btnClick1:(UIButton *)btn {
   //让按钮放大，变成透明
    [UIView animateWithDuration:0.5f animations:^{
        btn.alpha = 0;
        btn.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
