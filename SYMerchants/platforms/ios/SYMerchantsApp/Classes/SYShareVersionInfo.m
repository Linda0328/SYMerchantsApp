//
//  SYShareVersionInfo.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/25.
//
//

#import "SYShareVersionInfo.h"

@implementation SYShareVersionInfo
+ (instancetype)sharedVersion{
    static SYShareVersionInfo *shareVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareVersion = [[SYShareVersionInfo alloc]init];
        shareVersion.remoteUrl = [SYGlobleConst baseURL];
        shareVersion.imageUrl = [SYGlobleConst imagLoadURL];
        shareVersion.systemType = @"1";
        shareVersion.regId = @"";
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//        shareVersion.appVersionName = [infoDic objectForKey:@"CFBundleDisplayName"];
        shareVersion.appVersionName = [infoDic objectForKey:@"CFBundleShortVersionString"];
        shareVersion.appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        shareVersion.token = [def objectForKey:loadToken];
    });
    return shareVersion;
}
@end
