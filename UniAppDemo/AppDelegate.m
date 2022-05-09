//
//  AppDelegate.m
//  UniAppDemo
//
//  Created by wyzeww on 2022/4/28.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DCUniMP.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    
    // 配置参数
   NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
   // 设置 debug YES 会在控制台输出 js log，默认不输出 log，注：需要引入 liblibLog.a 库
   [options setObject:[NSNumber numberWithBool:YES] forKey:@"debug"];
   // 初始化引擎
   [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];
    
    return YES;
}

#pragma mark - App 生命周期方法
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [DCUniMPSDKEngine destory];
}

#pragma mark - 如果需要使用 URL Scheme 或 通用链接相关功能，请实现以下方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 通过 url scheme 唤起 App
    [DCUniMPSDKEngine application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    // 通过通用链接唤起 App
    [DCUniMPSDKEngine application:application continueUserActivity:userActivity];
    return YES;
}

@end
