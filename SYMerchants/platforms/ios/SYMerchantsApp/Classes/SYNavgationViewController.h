//
//  SYNavgationViewController.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/12/28.
//
//

#import <UIKit/UIKit.h>
#import "SYNavigatonBarModel.h"
#import "MainViewController.h"
typedef void(^pushViewControllerBlock)(NSString *contentUrl,BOOL isBackToLast,SYNavigatonBarModel *navModel);
@interface SYNavgationViewController : UIViewController
@property (nonatomic,strong)MainViewController *CurrentChildVC;
@property (nonatomic,copy)pushViewControllerBlock pushBlock;
@property (nonatomic,assign)BOOL isBackToLast;
+(SYNavgationViewController*)initWithFrame:(CGRect)rect;
-(void)setNavigationBar:(SYNavigatonBarModel *)navBarModel;
@end
