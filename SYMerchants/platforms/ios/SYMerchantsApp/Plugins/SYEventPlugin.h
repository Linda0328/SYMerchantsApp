//
//  SYEventPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

//#import <Cordova/Cordova.h>
#import <Cordova/CDV.h>
@interface SYEventPlugin : CDVPlugin

-(void)bind:(CDVInvokedUrlCommand*)command;;
-(void)listen:(CDVInvokedUrlCommand*)command;
@end
