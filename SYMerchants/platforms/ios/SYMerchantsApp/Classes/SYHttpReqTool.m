//
//  SYHttpReqTool.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/24.
//
//

#import "SYHttpReqTool.h"
#import "SYGlobleConst.h"
#import "NSString+MJExtension.h"
#import "SYShareVersionInfo.h"
static NSString * const SYVersionParam = @"/app_resources/app/version.json?_";
static NSString * const SYMainParam = @"/app_resources/app/main.json?_";
@implementation SYHttpReqTool
+(NSDictionary*)VersionInfo{
    NSString *baseURL = [SYGlobleConst baseURL];
    NSString *reqUrl = [baseURL stringByAppendingFormat:@"%@%@",SYVersionParam,[SYGlobleConst secondsForNow]];
    NSURL *url = [NSURL URLWithString:reqUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSLog(@"response : %@",response);
//        NSString *backData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"backData : %@",backData);
//
//    }];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"---版本信息请求出错---%@",[error description]);
        return nil;
    }
    NSError *err = nil;
    NSLog(@"responseMain : %@",response);
    NSString *backData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    backData = [backData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    backData = [backData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    backData = [backData stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSLog(@"backDataMain : %@",backData);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[backData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"---数据解析出错---%@",[err description]);
    }else{
        NSLog(@"----解析结果--- : %@",dic);
    }
    SYVersionModel *model = [SYVersionModel objectWithKeyValues:dic];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    [SYShareVersionInfo sharedVersion].pageVersion = model.pageVersion;
    [SYShareVersionInfo sharedVersion].lastAppVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    [SYShareVersionInfo sharedVersion].lastVersionName = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([SYGlobleConst judgeNSString:[def objectForKey:loadToken]]) {
        [SYShareVersionInfo sharedVersion].token = [def objectForKey:loadToken];
    }
    return dic;
    
}
+(NSDictionary*)MainData{
    NSString *baseURL = [SYGlobleConst baseURL];
    NSString *reqUrl = [baseURL stringByAppendingFormat:@"%@%@",SYMainParam,[SYShareVersionInfo sharedVersion].pageVersion];
    NSURL *url = [NSURL URLWithString:reqUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
    //        NSLog(@"response : %@",response);
    //        NSString *backData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //        NSLog(@"backData : %@",backData);
    //
    //    }];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"---版本信息请求出错---%@",[error description]);
        return nil;
    }
    NSError *err = nil;
    NSLog(@"responseMain : %@",response);
    
    NSString *backData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    backData = [backData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    backData = [backData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    backData = [backData stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSLog(@"backDataMain : %@",backData);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[backData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"---数据解析出错---%@",[err description]);
    }else{
        NSLog(@"----解析结果--- : %@",dic);
    }
    return dic;
    
}
@end
