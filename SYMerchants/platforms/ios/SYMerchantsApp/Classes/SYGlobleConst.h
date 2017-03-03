//
//  SYGlobleConst.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/23.
//
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "SYVersionModel.h"
#import <Cordova/CDVViewController.h>
extern NSString * const bundleID;
extern NSString * const appID;
extern NSString *const updateNotify;
extern NSString *const hideNotify;
extern NSString *const scanNotify;
extern NSString *const popAndReloadNotify;
extern NSString *const popNotify;
extern NSString *const loadToken;
extern NSString *const loadTokenChanged;
extern NSString *const loadAppNotify;
//extern NSString *const showGuider;
@interface SYGlobleConst : NSObject

+(void)guiderAlready;
+(BOOL)guiderOrNot;
+(CGFloat)deviceWidth;
+(CGFloat)deviceHeigth;
+(CGFloat)navigationBarWithStatusBarHeight;
+(CGFloat)TabbarHeight;

+(NSString*)secondsForNow;

+(BOOL)judgeNSString:(NSString*)str;

+(id)getMainModel;
+(SYVersionModel*)getVersionModel;
//+(id)getVersionModel;


+(NSString*)baseURL;
+(NSString*)imagLoadURL;
+(NSURL*)appUrl:(CDVViewController*)CDV;

+(NSArray*)guiderImageS;
@end
