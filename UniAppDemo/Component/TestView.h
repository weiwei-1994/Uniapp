//
//  TestView.h
//  UniAppDemo
//
//  Created by shenWenFeng on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TestView;

@protocol TestViewDelegate <NSObject>

-(void)TestView:(TestView*)TestView clickBtn:(UIButton*)btn;

@end

@interface TestView : UIView

@property(weak, nonatomic) id<TestViewDelegate> delegate;


@property(strong,nonatomic)UIButton * btn;


@end

NS_ASSUME_NONNULL_END
