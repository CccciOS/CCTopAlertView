//
//  TopAlertView.m
//  CCTopAlertView
//
//  Created by 崔璨 on 2017/8/22.
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "TopAlertView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kAlertViewHeight 64
@interface TopAlertView()
{
    CGFloat stayTime;

}
@property (nonatomic , assign)NSInteger backCountDown;
@property (nonatomic ,strong)NSTimer *backTimer;

@property (nonatomic , strong)UIImageView *imageV;
@property (nonatomic , strong)UILabel *titleLab;
@end
@implementation TopAlertView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**

 @param color 背景色
 @param setStayTime 停留时间
 @param imageStr 图片名
 @param titleStr 标题
 @param titleColor 标题字体颜色
 
 */
+ (void)SetUpbackgroundColor:(UIColor *)color andStayTime:(CGFloat)setStayTime andImageName:(NSString *)imageStr andTitleStr:(NSString *)titleStr andTitleColor:(UIColor *)titleColor{
    TopAlertView *alert = [[TopAlertView alloc]init];
    
    [alert setupView:color andStayTime:setStayTime andImageName:imageStr andTitleStr:titleStr  andTitleColor:titleColor];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
}

- (id)init{
   
  if (self = [super init]){
       
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kAlertViewHeight);
      
       [self setupViews];
       [self startPosition];
       [self setDeclineAnimation];
   }
    return self;
}

- (void)setupViews
{
    self.imageV = [[UIImageView alloc]init];
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.height*0.8 , self.frame.size.height*0.8);
    self.imageV.center = CGPointMake(self.imageV.frame.size.width/2 + 5 , self.frame.size.height/2);
    [self addSubview: self.imageV];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 5, 0, self.frame.size.width - self.imageV.frame.size.width - 5 - 5 - 5, self.frame.size.height);
    self.titleLab.font = [UIFont fontWithName:@"STHeitiSC-Light" size:self.titleLab.frame.size.height/3];
    self.titleLab.numberOfLines = 0;
    [self addSubview:self.titleLab];
    
    
}
- (void)setupView:(UIColor *)color andStayTime:(CGFloat)setStayTime andImageName:(NSString *)imageStr andTitleStr:(NSString *)titleStr andTitleColor:(UIColor *)titleColor
{
    stayTime = setStayTime;
    self.backgroundColor = color;
    self.imageV.image = [UIImage imageNamed:imageStr];
    self.titleLab.textColor = titleColor;
    self.titleLab.text = titleStr;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [self addGestureRecognizer:singleTap];
}

-(void)touch
{
    [self setGoUpAnimation];
   
}

//初始位置
- (void)startPosition
{
    self.center = CGPointMake(SCREEN_WIDTH/2, -self.frame.size.height/2);
}

//最终位置
- (void)endPosition
{
    self.center = CGPointMake(SCREEN_WIDTH/2, kAlertViewHeight/2);
}

//下降
- (void)setDeclineAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [self endPosition];
        
    } completion:^(BOOL finished) {
        
        if (stayTime >= 0) {
            [self backTime];
        }
        
        
    }];
    
    
}

//上升
- (void)setGoUpAnimation
{
     [self.backTimer invalidate];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self startPosition];
        
    } completion:^(BOOL finished) {
        
        [self removeSelf];
        
    }];
}


- (void)backTime

{
    
    //设置倒计时总时长
    [self.backTimer invalidate];
    self.backCountDown = stayTime;
    self.backTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(viewBackNSTimer) userInfo:nil repeats:YES];
    
}

//使用NSTimer实现倒计时
- (void)viewBackNSTimer

{
    
    self.backCountDown -- ;
    
    if (self.backCountDown == 0  || self.backCountDown < 0) {
        [self.backTimer invalidate];
        [self setGoUpAnimation];
    }
    
}

-(void)removeSelf
{
    [self removeFromSuperview];
}
@end
