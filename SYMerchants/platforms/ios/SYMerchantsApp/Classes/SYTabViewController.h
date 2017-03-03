//
//  SYTabViewController.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/24.
//
//

#import <UIKit/UIKit.h>
#import "SYGlobleConst.h"
#import "SYModel.h"
#import "SYMainModel.h"
#import "SYNavigatonBarModel.h"
#import "SYNavigationItemModel.h"
#import "SYTabbarModel.h"
@interface SYTabViewController : UITabBarController
//@property(nonatomic,strong)NSArray *tabbarItems;
//@property(nonatomic,strong)NSArray *navigationBars;
-(void)InitTabBarWithtabbarItems:(NSArray*)tabbarItems navigationBars:(NSArray*)navigationBars;
@end
