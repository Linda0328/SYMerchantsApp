//
//  SYResultPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import "SYResultPlugin.h"
#import "MainViewController.h"
#import "SYShareVersionInfo.h"
@implementation SYResultPlugin
-(void)reload:(CDVInvokedUrlCommand *)command{

    MainViewController *main = (MainViewController*)self.viewController;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:popNotify object:main];
    if (main.lastViewController.reloadB) {
        main.lastViewController.reloadB(nil);
    }

    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"reload"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
-(void)finish:(CDVInvokedUrlCommand *)command{
    MainViewController *main = (MainViewController*)self.viewController;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:popNotify object:main];
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"finish"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
-(void)exec:(CDVInvokedUrlCommand *)command{
    NSString *function = [command.arguments firstObject];
    NSDictionary *data = [command.arguments objectAtIndex:1];
    MainViewController *main = (MainViewController*)self.viewController;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:popNotify object:main];
    if(main.lastViewController.execB){
        main.lastViewController.execB(function,data);
    }
    [self.commandDelegate runInBackground:^{
        [SYShareVersionInfo sharedVersion].listenPluginID = command.callbackId;
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"exec"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
@end
