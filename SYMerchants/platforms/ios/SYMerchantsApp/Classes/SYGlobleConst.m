//
//  SYGlobleConst.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/23.
//
//

#import "SYGlobleConst.h"
#import "SYShareVersionInfo.h"
NSString * const bundleID = @"com.example.SYMerchants";
NSString * const appID = @"MainData";
static NSString * const SYMainJson = @"MainData";
static NSString * const SYVersionJson = @"Version";
static NSString * const SYSGMerchantsTestBaseURL = @"http://test.shengyuan.cn:7086"; //测试服务器
static NSString * const SYSGMerchantsLocalBaseURL = @"http://172.16.0.143:9090"; //本地服务器
static NSString * const SYSGMerchantsFormalBaseURL = @"http://sj.shengyuan.cn"; //正式服务器
static NSString * const SYSGIMGloadTestBaseURL = @"http://test.shengyuan.cn"; //测试服务器
static NSString * const SYSGIMGloadFormalBaseURL = @"http://storage.shengyuan.cn"; //正式服务器

NSString *const updateNotify = @"updateOrNot";
NSString *const hideNotify = @"hideNotice";

NSString *const popAndReloadNotify = @"PushVCandReload";
NSString *const popNotify = @"PushVCandReload";
NSString *const scanNotify = @"PushScanVC";

NSString *const loadToken = @"LoadToken";
NSString *const loadAppNotify = @"LoadApp";
NSString *const showGuider = @"guider";
@implementation SYGlobleConst

+(NSString*)secondsForNow{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval seconds = [nowDate timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%f",seconds];
    return time;
}
+(void)guiderAlready{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:showGuider];
    [user synchronize];
}
+(BOOL)guiderOrNot{
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   return [user boolForKey:showGuider];
}
+(BOOL)judgeNSString:(NSString*)str{
    if (![str isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@",str];
    }
    if (!str) {
        return NO;
    }
   
    if ([str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[NSNull null] isEqual:str]) {
        return NO;
    }
    if (str.length == 0) {
        return NO;
    }
    if ([@"(null)" isEqualToString:str]) {
        return NO;
    }
    if ([@"<null>" isEqualToString:str]) {
        return NO;
    }
    return YES;
}

+(CGFloat)deviceWidth{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    return width;
}
+(CGFloat)deviceHeigth{
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    return height;
}

+(CGFloat)navigationBarWithStatusBarHeight{
//    CGFloat statusBarheight = [SYGlobleConst deviceHeigth]>568?27:20;
    CGFloat navigationBarHeight = [SYGlobleConst deviceHeigth]>568?66:44;
    return navigationBarHeight;
}
+(CGFloat)TabbarHeight{
    CGFloat tabbarHeight = [SYGlobleConst deviceHeigth]>568?73:48;
    return tabbarHeight;
}
+(id)getMainModel{
    // 读取Json数据
    NSString *path = [[NSBundle mainBundle] pathForResource:SYMainJson ofType:@"geojson"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // JsonObject
    NSError *error;
    id JsonObject = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    return JsonObject;
}

+(SYVersionModel*)getVersionModel{
    // 读取Json数据
    NSString *path = [[NSBundle mainBundle] pathForResource:SYVersionJson ofType:@"geojson"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // JsonObject
    NSError *error;
    id JsonObject = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    SYVersionModel *model = [SYVersionModel objectWithKeyValues:JsonObject];
    [SYShareVersionInfo sharedVersion].pageVersion = model.pageVersion;
//    [SYShareVersionInfo sharedVersion].lastAppVersion = model.iosVersion;
//    [SYShareVersionInfo sharedVersion].lastVersionName = model.iosVersionName;
    return model;
}
//+(id)getVersionModel{
//    NSString *path = [[NSBundle mainBundle] pathForResource:SYVersionJson ofType:@"geojson"];
//    NSData *fileData = [NSData dataWithContentsOfFile:path];
//    
//    // JsonObject
//    NSError *error;
//    id JsonObject = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
//    return JsonObject;
//}

+(NSString*)baseURL{
    NSString *baseURL = nil;
//    if (DEBUG) {
////    baseURL = SYSGMerchantsLocalBaseURL;
//
//         baseURL = SYSGMerchantsTestBaseURL;
//    }else{
        baseURL = SYSGMerchantsFormalBaseURL;
//    }
    return baseURL;
}

+(NSString*)imagLoadURL{
    NSString *imagLoadURL = nil;
//    if (DEBUG) {
//        imagLoadURL = SYSGIMGloadTestBaseURL;
//    }else{
        imagLoadURL = SYSGIMGloadFormalBaseURL;
//    }
    return imagLoadURL;
}
+(NSURL*)appUrl:(CDVViewController*)CDV
{
    NSURL* appURL = nil;
    
    if ([CDV.startPage rangeOfString:@"://"].location != NSNotFound) {
        appURL = [NSURL URLWithString:CDV.startPage];
    } else if ([CDV.wwwFolderName rangeOfString:@"://"].location != NSNotFound) {
        appURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", CDV.wwwFolderName, CDV.startPage]];
    } else if([CDV.wwwFolderName hasSuffix:@".bundle"]){
        // www folder is actually a bundle
        NSBundle* bundle = [NSBundle bundleWithPath:CDV.wwwFolderName];
        appURL = [bundle URLForResource:CDV.startPage withExtension:nil];
    } else if([CDV.wwwFolderName hasSuffix:@".framework"]){
        // www folder is actually a framework
        NSBundle* bundle = [NSBundle bundleWithPath:CDV.wwwFolderName];
        appURL = [bundle URLForResource:CDV.startPage withExtension:nil];
    } else {
        // CB-3005 strip parameters from start page to check if page exists in resources
        NSURL* startURL = [NSURL URLWithString:CDV.startPage];
        NSString* startFilePath = [CDV.commandDelegate pathForResource:[startURL path]];
        
        if (startFilePath == nil) {
            appURL = nil;
        } else {
            appURL = [NSURL fileURLWithPath:startFilePath];
            // CB-3005 Add on the query params or fragment.
            NSString* startPageNoParentDirs = CDV.startPage;
            NSRange r = [startPageNoParentDirs rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"?#"] options:0];
            if (r.location != NSNotFound) {
                NSString* queryAndOrFragment = [CDV.startPage substringFromIndex:r.location];
                appURL = [NSURL URLWithString:queryAndOrFragment relativeToURL:appURL];
            }
        }
    }
    
    return appURL;
}

+(NSMutableArray*)guiderImageS{
    NSMutableArray *arr = [NSMutableArray array];
//    NSString *wh = [NSString stringWithFormat:@"%.0fx%.0f-",2*[SYGlobleConst deviceWidth],2*[SYGlobleConst deviceHeigth]];
    NSString *wh = @"640x960-";
    if ([SYGlobleConst deviceWidth]>375) {
        wh = @"1080x1920-";
    }else if ([SYGlobleConst deviceWidth]>320) {
        wh = @"750x1334-";
    }else{
        if ([SYGlobleConst deviceHeigth]>480) {
            wh = @"640x1136-";
        }

    }
    for (NSInteger i = 1 ; i<4; i++) {
        NSString *newWH = [wh stringByAppendingFormat:@"%zd.png",i];
        [arr addObject:newWH];
    }
    return arr;
}
@end
