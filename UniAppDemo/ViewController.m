//
//  ViewController.m
//  UniAppDemo
//
//  Created by wyzeww on 2022/4/28.
//

#import "ViewController.h"
#import "DCUniMP.h"
#import <AFNetworking/AFNetworking.h>

static NSString * demoPluginId = @"__UNI__31914F5";

@interface ViewController ()<DCUniMPSDKEngineDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIButton * downLoadButton = [UIButton buttonWithType:0];
    downLoadButton.frame = CGRectMake(10, 100, 50, 50);
    downLoadButton.backgroundColor = [UIColor redColor];
    [downLoadButton setTitle:@"down" forState:UIControlStateNormal];
    [downLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downLoadButton addTarget:self action:@selector(downOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downLoadButton];
    
    UIButton * openButton = [UIButton buttonWithType:0];
    openButton.frame = CGRectMake(100, 100, 50, 50);
    openButton.backgroundColor = [UIColor redColor];
    [openButton setTitle:@"open" forState:UIControlStateNormal];
    [openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openButton addTarget:self action:@selector(openOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openButton];
    // Do any additional setup after loading the view.
}

- (NSString *)documentsDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
    */
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}

- (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}

/// 检查运行目录是否存在应用资源，不存在将应用资源部署到运行目录
- (void)checkUniMPResource:(NSString *)appid {
#warning 注意：isExistsUniMP: 方法判断的仅是运行路径中是否有对应的应用资源，宿主还需要做好内置wgt版本的管理，如果更新了内置的wgt也应该执行 installUniMPResourceWithAppid 方法应用最新的资源
//    if (![DCUniMPSDKEngine isExistsUniMP:appid]) {
        // 读取导入到工程中的wgt应用资源
        NSString *appResourcePath = [self getPluginPathWithAppid:appid];
        if (!appResourcePath) {
            NSLog(@"资源路径不正确，请检查");
            return;
        }
        // 将应用资源部署到运行路径中
        NSError *error;
        if ([DCUniMPSDKEngine installUniMPResourceWithAppid:appid resourceFilePath:appResourcePath password:nil error:&error]) {
            NSLog(@"小程序 %@ 应用资源文件部署成功，版本信息：%@",appid,[DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid]);
        } else {
            NSLog(@"小程序 %@ 应用资源部署失败： %@",appid,error);
        }
//    } else {
//        NSLog(@"已存在小程序 %@ 应用资源，版本信息：%@",appid,[DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid]);
//    }
}

-(void)downOperation{
    
    [self downLoadPluginWthPluginId:demoPluginId];
    
}

-(void)openOperation{
    
    [self openPluginWithAppid:demoPluginId];
}

-(void)downLoadPluginWthPluginId:(NSString *)appid{
    if (![self isExistsAtPath:[self getPluginsPath]]) {
        BOOL isCreat = [self createDirectoryAtPath:[self getPluginsPath] error:nil];
        NSLog(@"创建是否成功%@",@(isCreat));
    }
    
    if ([self isExistsAtPath:[self getPluginPathWithAppid:appid]]) {
        [self removeItemAtPath:[self getPluginPathWithAppid:appid] error:nil];
    }
    
    //下载插件包
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",@"http://192.168.68.149:8080/",appid,@".wgt"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString * path = [self getPluginPathWithAppid:appid];
        NSURL *url = [NSURL fileURLWithPath:path];
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self checkUniMPResource:appid];
    }];
    [downloadTask resume];
}

-(NSString *)getPluginsPath{
    return [NSString stringWithFormat:@"%@/%@",[self documentsDir],@"Plugins"];
}

-(NSString *)getPluginPathWithAppid:(NSString *)appid{
    return [[self getPluginsPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wgt",appid]];
}

-(void)openPluginWithAppid:(NSString *)appid{
    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    [DCUniMPSDKEngine openUniMP:appid configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
        if (uniMPInstance) {
            // success
        } else {
            // error
        }
    }];
}

@end
