/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  SYMerchantsApp
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SYHttpReqTool.h"
#import "SYTabViewController.h"
#import "SYGlobleConst.h"
#import "SYShareVersionInfo.h"
#import "SYGuiderViewController.h"
#import "SYNavgationViewController.h"
#import "XZMCoreNewFeatureVC.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "SYReachableNotViewController.h"
#import "MBProgressHUD.h"
@interface AppDelegate()
@property (nonatomic,strong)Reachability *hostReach;

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];    
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.autoresizesSubviews = YES;
//    [self versionUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    __weak __typeof(self)weakSelf = self;
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReach startNotifier];
    SYReachableNotViewController *rec = [[SYReachableNotViewController alloc]init];
    rec.refreshB = ^(){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.isReachable) {
            [SYHttpReqTool VersionInfo];
            NSDictionary *jsondic = [SYHttpReqTool MainData];
            NSLog(@"进入主页面");
            [strongSelf getMainModel:jsondic];
        }
    };
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:rec];
    [SYHttpReqTool VersionInfo];
    NSDictionary *jsondic = [SYHttpReqTool MainData];
    NSLog(@"进入主页面");
    [self getMainModel:jsondic];
//    self.window.rootViewController = navC;
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [XZMCoreNewFeatureVC canShowNewFeature];
    //    BOOL guiderShow = [[NSUserDefaults standardUserDefaults] boolForKey:GuiderShow];
    if(canShow){ // 初始化新特性界面
        self.window.rootViewController = [XZMCoreNewFeatureVC newFeatureVCWithImageNames:[SYGlobleConst guiderImageS] enterBlock:^{
             __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (strongSelf.isReachable) {
                [SYHttpReqTool VersionInfo];
                NSDictionary *jsondic = [SYHttpReqTool MainData];
                NSLog(@"进入主页面");
                [strongSelf getMainModel:jsondic];
            }else{
                strongSelf.window.rootViewController = navC;
            }
        } configuration:^(UIButton *enterButton) { // 配置进入按钮
            [enterButton setTitle:@"立即进入" forState:UIControlStateNormal];
            [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            enterButton.layer.masksToBounds = YES;
            enterButton.layer.cornerRadius = 10;
            enterButton.layer.borderWidth = 1;
            enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
            enterButton.bounds = CGRectMake(0, 0, 100, 40);
            enterButton.center = CGPointMake(KScreenW * 0.8, KScreenH* 0.08);
        }];
    }
    [self.window makeKeyAndVisible];
    return YES;

}
-(void)getMainModel:(NSDictionary*)jsonDic{
//    id JsonData = [SYGlobleConst getMainModel];
    [SYNavigationItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
   
    [SYModel setupObjectClassInArray:^NSDictionary *{
        return @{@"bottomBarConfig":@"SYNavigatonBarModel"};
    }];
    SYModel *model = [SYModel objectWithKeyValues:jsonDic];
    [SYTabbarModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [SYMainModel setupObjectClassInArray:^NSDictionary *{
        return @{@"leftBtns":@"SYNavigationItemModel",
                 @"rightBtns":@"SYNavigationItemModel",
                 @"bottomBtns":@"SYTabbarModel",};
    }];
    SYMainModel *mainModel = [SYMainModel objectWithKeyValues:model.titleBarConfig];
    
    SYTabViewController *tabC = [[SYTabViewController alloc] init];
    [tabC InitTabBarWithtabbarItems:mainModel.bottomBtns navigationBars:model.bottomBarConfig];
    self.window.rootViewController = tabC;
}
-(void)versionUpdate{
    NSString *itunes = @"https://itunes.apple.com/lookup?id=";
    NSString *appItunes = [itunes stringByAppendingString:appID];
    NSString *appVersion = [NSString stringWithContentsOfURL:[NSURL URLWithString:appItunes] encoding:NSUTF8StringEncoding error:nil];
    if (!appVersion && [appVersion length]>0 && [appVersion rangeOfString:@"version"].length==7) {
        NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
        NSString *appInfo = [appVersion substringFromIndex:[appVersion rangeOfString:@"\"version\":"].location+10];
        appInfo = [[appInfo substringToIndex:[appInfo rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [SYShareVersionInfo sharedVersion].lastAppVersion = appInfo;
        [SYShareVersionInfo sharedVersion].lastVersionName = appInfo;
        if (![appInfo isEqualToString:version]) {
            [SYShareVersionInfo sharedVersion].needUpdate = YES;
        }else{
            [SYShareVersionInfo sharedVersion].needUpdate = NO;
        }
        
    }
    
}
//网络变化
-(void)reachabilityChanged:(NSNotification*)notify{
    
    Reachability *currentReach = [notify object];
//    NSParameterAssert([currentReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [currentReach currentReachabilityStatus];
    self.isReachable = YES;
   
    if (status == NotReachable) {
        self.isReachable = NO;
        SYReachableNotViewController *rec = [[SYReachableNotViewController alloc]init];
        UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:rec];
        __weak __typeof(self)weakSelf = self;
        rec.refreshB = ^(){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (strongSelf.isReachable) {
                MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.window];
                [self.window.rootViewController.view addSubview:HUD];
                HUD.labelText = @"正在加载数据";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1.5f];
                [SYHttpReqTool VersionInfo];
                NSDictionary *jsondic = [SYHttpReqTool MainData];
                NSLog(@"进入主页面");
                [strongSelf getMainModel:jsondic];
                
            }else{
                MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.window];
                [navC.view addSubview:HUD];
                HUD.labelText = @"无网络连接，无法加载数据";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1.5f];
            }
        };
        
        self.window.rootViewController = navC;
        return;
    }
    if (status == ReachableViaWiFi||status == ReachableViaWWAN) {
        self.isReachable = YES;
       
    }
   

}
-(void)save{
    //加载HTML页面存放到沙盒中
    //    NSString *curFilePath = [NSString stringWithFormat:@"file://%@/www",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)];
    //    NSLog(@"路径为：%@",curFilePath);
    //    if ([[NSFileManager defaultManager]fileExistsAtPath:curFilePath]) {
    //        self.viewController.wwwFolderName = curFilePath;
    //    }
    //    self.viewController.startPage = @"index.html";

}
@end
