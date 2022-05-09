//
//  TestModule.m
//  UniAppDemo
//
//  Created by shenWenFeng on 2022/5/7.
//

#import "TestModule.h"


@implementation TestModule

// 通过宏 WX_EXPORT_METHOD 将异步方法暴露给 js 端
WX_EXPORT_METHOD(@selector(getUsernumberAsyncFunc:callback:))

// 通过宏 WX_EXPORT_METHOD_SYNC 将同步方法暴露给 js 端
WX_EXPORT_METHOD_SYNC(@selector(getUsernameSyncFunc:))

WX_EXPORT_METHOD_SYNC(@selector(addLog:))

/// 异步方法（注：异步方法会在主线程（UI线程）执行）
/// @param options js 端调用方法时传递的参数
/// @param callback 回调方法，回传参数给 js 端
- (void)getUsernumberAsyncFunc:(NSDictionary *)options callback:(WXModuleKeepAliveCallback)callback {
    // options 为 js 端调用此方法时传递的参数
    NSLog(@"%@",options);

    // 可以在该方法中实现原生能力，然后通过 callback 回调到 js

    // 回调方法，传递参数给 js 端 注：只支持返回 String 或 NSDictionary (map) 类型
    if (callback) {
        // 第一个参数为回传给js端的数据，第二个参数为标识，表示该回调方法是否支持多次调用，如果原生端需要多次回调js端则第二个参数传 YES;
        callback(@"17600330098",NO);
    }
}

/// 同步方法（注：同步方法会在 js 线程执行）
/// @param options js 端调用方法时传递的参数
- (NSString *)getUsernameSyncFunc:(NSDictionary *)options {
    // options 为 js 端调用此方法时传递的参数
    NSLog(@"%@",options);

    /*
     可以在该方法中实现原生功能，然后直接通过 return 返回参数给 js
     */

    // 同步返回参数给 js 端 注：只支持返回 String 或 NSDictionary (map) 类型
    return @"张三李四";
}

- (void)addLog:(NSString *)options {
    NSLog(@"%@",options);

}


@end
