//
//  TestView.m
//  UniAppDemo
//
//  Created by shenWenFeng on 2022/5/7.
//

#import "TestView.h"

@interface TestView()

@end

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.backgroundColor = [UIColor redColor];
    UIButton * Button = [UIButton buttonWithType:0];
    Button.frame = CGRectMake(10, 10, 100, 100);
    Button.backgroundColor = [UIColor greenColor];
    
    Button.layer.cornerRadius = 10;
    Button.layer.masksToBounds = YES;
    
    [Button setTitle:@"我是大按钮" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
    self.btn = Button;
}

-(void)clickBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TestView:clickBtn:)]) {
        [self.delegate TestView:self clickBtn:btn];
    }
}
@end
