//
//  SYGuiderViewController.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/30.
//
//

#import <UIKit/UIKit.h>
typedef void (^dismissGuider)();
@interface SYGuiderViewController : UIViewController
@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,copy)dismissGuider dismissBlock;
@end
