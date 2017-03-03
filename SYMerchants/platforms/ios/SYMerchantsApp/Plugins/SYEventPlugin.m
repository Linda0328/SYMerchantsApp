//
//  SYEventPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import "SYEventPlugin.h"
#import "SYShareVersionInfo.h"
#import "SYEventModel.h"
#import "SYEventButton.h"
@implementation SYEventPlugin

-(void)bind:(CDVInvokedUrlCommand *)command{
    NSArray *eventArr = [command.arguments firstObject];
//    NSString *eventJson = [command.arguments firstObject];
//    NSArray *eventArr = [NSJSONSerialization JSONObjectWithData:[eventJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    [SYEventModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    NSArray *eventModelArr = [SYEventModel objectArrayWithKeyValuesArray:eventArr];
    [self.commandDelegate runInBackground:^{
        for (SYEventModel *model in eventModelArr) {
           NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
           [userDef setObject:model.event forKey:model.ID];
           [userDef synchronize];
        }
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];

}

-(void)listen:(CDVInvokedUrlCommand *)command{
    NSString *comebackID = command.callbackId;
    [self.commandDelegate runInBackground:^{
        [SYShareVersionInfo sharedVersion].listenPluginID = comebackID;
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        [self.commandDelegate sendPluginResult:result callbackId:comebackID];
    }];
}
@end
