/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  SYMerchantsApp
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>
#import "SYNavigatonBarModel.h"

typedef void (^reloadBlock)(NSString *url);

typedef void(^showProgressBlock)(NSString *msg,double time);
typedef void(^execBlock)(NSString *function,NSDictionary *data);
typedef void(^pushViewControllerBlock)(NSString *contentUrl,BOOL isBackToLast,SYNavigatonBarModel *navModel);
@interface MainViewController : CDVViewController
@property (nonatomic,copy)reloadBlock reloadB;
@property (nonatomic,copy)showProgressBlock showB;
@property (nonatomic,copy)execBlock execB;

//-(void)setNavigationBar:(SYNavigatonBarModel *)navBarModel;
-(void)LoadURL:(NSString*)url;
//当前main的上级视图
@property (nonatomic,strong)MainViewController *lastViewController;
@property (nonatomic,copy)NSString *scanResult;
@property (nonatomic,assign)BOOL isRoot;
@property (nonatomic,assign)BOOL isChild;
@end

@interface MainCommandDelegate : CDVCommandDelegateImpl
@end

@interface MainCommandQueue : CDVCommandQueue
@end
