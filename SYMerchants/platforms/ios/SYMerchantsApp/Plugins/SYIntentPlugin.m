//
//  SYIntentPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import "SYIntentPlugin.h"

#import "SYNavigatonBarModel.h"
#import "MainViewController.h"
#import "SYNavgationViewController.h"
@implementation SYIntentPlugin
-(void)open:(CDVInvokedUrlCommand *)command{

    NSString *loadUrl = [command.arguments firstObject];
    //重载URL
    MainViewController *mainVC = (MainViewController*)self.viewController;
    
    if (mainVC.reloadB) {
        mainVC.reloadB(loadUrl);
    }
    //        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //        [center postNotificationName:loadUrlNotify object:laodUrl];

    [self.commandDelegate runInBackground:^{
          CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:loadUrl];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
-(void)start:(CDVInvokedUrlCommand *)command{
    NSString *url = [command.arguments firstObject];
    BOOL isfinish = [[command.arguments objectAtIndex:1] boolValue];
    NSDictionary *titleBar = [command.arguments objectAtIndex:2];
//    NSDictionary *titleBarDic = [NSJSONSerialization JSONObjectWithData:[titleBar dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    SYNavigatonBarModel *model = [SYNavigatonBarModel objectWithKeyValues:titleBar];
    model.url = url;
    MainViewController *mainVC = (MainViewController*)self.viewController;
    if (mainVC.isChild) {
        SYNavgationViewController *navVC = (SYNavgationViewController *)mainVC.parentViewController;
        if (navVC.pushBlock) {
            navVC.pushBlock(url,!isfinish,model);
        }
        
    }    
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:url];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];

}

@end
