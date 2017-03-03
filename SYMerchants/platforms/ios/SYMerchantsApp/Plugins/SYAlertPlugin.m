//
//  SYAlertPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/18.
//
//

#import "SYAlertPlugin.h"

@implementation SYAlertPlugin
-(void)alertTest:(CDVInvokedUrlCommand*)command{
////    这是回调JS方法
//        CDVPluginResult *result = nil;
//        NSString *comeback = [command.arguments firstObject];
//        if (comeback) {
//            //成功回调 CDVCommandStatus_OK
//            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
//        }else{
//            //失败回调 CDVCommandStatus_ERROR
//            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
//        }
//        //通过代理将数据传递给JS
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
   
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:@"你好世界！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [alertview show];

}
@end
