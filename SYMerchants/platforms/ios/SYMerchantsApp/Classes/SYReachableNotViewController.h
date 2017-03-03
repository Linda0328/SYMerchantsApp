//
//  SYReachableNotViewController.h
//  SYMerchantsApp
//
//  Created by 文清 on 2017/2/4.
//
//

#import <UIKit/UIKit.h>

typedef void (^reFreshBlock)();

@interface SYReachableNotViewController : UIViewController
@property (nonatomic,copy)reFreshBlock refreshB;
@end
