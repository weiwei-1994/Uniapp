//
//  TestComponent.m
//  UniAppDemo
//
//  Created by shenWenFeng on 2022/5/7.
//

#import "TestComponent.h"
#import "TestView.h"

@interface TestComponent()<TestViewDelegate>

@property (strong, nonatomic) TestView * myView;
@end

@implementation TestComponent


WX_EXPORT_METHOD(@selector(changeTitle:))

- (void)changeTitle:(NSString *)title{
    [self.myView.btn setTitle:title forState:UIControlStateNormal];
    NSLog(@"小程序调用更改按钮文字方法");
    
}


- (UIView *)loadView {
    self.myView = [TestView new];
    return self.myView;
}

- (void)viewDidLoad {
      ((TestView*)self.view).delegate = self;
}


/// 前端注册的事件会调用此方法
/// @param eventName 事件名称
- (void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"clickBtn"]) {
//        _mapLoadedEvent = YES;
        NSLog(@"小程序注册啦%@事件",eventName);
    }
}

/// 对应的移除事件回调方法
/// @param eventName 事件名称
- (void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"clickBtn"]) {
//        _mapLoadedEvent = NO;
        NSLog(@"小程序移除啦%@事件",eventName);
    }
}



-(void)TestView:(TestView*)TestView clickBtn:(UIButton*)btn;{
    [self fireEvent:@"clickBtn" params:@{@"detail":@{@"mapLoaded":@"success"}} domChanges:nil];
}

@end
