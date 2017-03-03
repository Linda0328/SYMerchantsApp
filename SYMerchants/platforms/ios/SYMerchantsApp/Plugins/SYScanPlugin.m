//
//  SYScanPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import "SYScanPlugin.h"
#import "MainViewController.h"
#import "SYShareVersionInfo.h"
#import "SYNavgationViewController.h"
@implementation SYScanPlugin

-(void)getCode:(CDVInvokedUrlCommand *)command{
    MainViewController *mainVC = (MainViewController*)self.viewController;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:scanNotify object:mainVC];
    [self.commandDelegate runInBackground:^{
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[SYShareVersionInfo sharedVersion].scanResult];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        [SYShareVersionInfo sharedVersion].listenPluginID = command.callbackId;
    }];
}
@end
