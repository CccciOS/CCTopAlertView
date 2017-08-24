//
//  ViewController.m
//  CCTopAlertView
//
//  Created by 崔璨 on 2017/8/22.
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "ViewController.h"
#import "TopAlertView.h"
@interface ViewController ()
@property (strong , nonatomic)TopAlertView *alertV;
@property(strong , nonatomic)UIButton *btn1;
@end

@implementation ViewController

- (UIButton *)btn1
{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(0, 0, 200, 100);
        _btn1.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
        _btn1.backgroundColor = [UIColor blueColor];
        [_btn1 setTitle:@"点我出来" forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(void)btn1:(UIButton *)btn
{
    [TopAlertView SetUpbackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.8] andStayTime:3 andImageName:@"1" andTitleStr:@"这是一条测试..." andTitleColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.btn1];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
