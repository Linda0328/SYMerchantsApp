//
//  SYVersionPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/19.
//
//

#import <Cordova/CDV.h>

@interface SYVersionPlugin : CDVPlugin

-(void)getInfo:(CDVInvokedUrlCommand*)command;
-(void)setToken:(CDVInvokedUrlCommand*)command;
-(void)setNeedPush:(CDVInvokedUrlCommand*)command;
@end
