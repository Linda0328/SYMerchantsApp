//
//  SYTabViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/24.
//
//

#import "SYTabViewController.h"
#import "HexColor.h"
#import "MainViewController.h"
#import "SYNavViewController.h"
#import "SYGuiderViewController.h"
#import "SYNavgationViewController.h"
@interface SYTabViewController ()
@property (nonatomic,strong)UIWindow *guiderWindow;
@end

@implementation SYTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (![SYGlobleConst guiderOrNot]) {
//        [self showGuiderWindow];
//        [SYGlobleConst guiderAlready];
//    }
    
    
}
-(void)showGuiderWindow{
    if (!_guiderWindow) {
        _guiderWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        SYGuiderViewController *guiderV = [[SYGuiderViewController alloc]init];
        guiderV.imageArr = [SYGlobleConst guiderImageS];
        __weak __typeof(self)weakSelf = self;
        guiderV.dismissBlock = ^{
             __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf dismissGuiderWindow];
           
        };
    
        [self.guiderWindow setRootViewController:guiderV];
       
    }
    [self.guiderWindow makeKeyAndVisible];
}


-(void)dismissGuiderWindow{
    [UIView animateWithDuration:0.5 animations:^{
        self.guiderWindow.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.guiderWindow.hidden = YES;
        self.guiderWindow.rootViewController = nil;
        self.guiderWindow = nil;
    }];
}
-(void)InitTabBarWithtabbarItems:(NSArray*)tabbarItems navigationBars:(NSArray*)navigationBars{
    
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSInteger i = 0; i < [tabbarItems count]; i++) {
        SYTabbarModel *tabModel = [tabbarItems objectAtIndex:i];
        SYNavigatonBarModel *navBarModel = [navigationBars objectAtIndex:i];
        SYNavgationViewController *viewC =[[SYNavgationViewController alloc]init];
        [viewC setNavigationBar:navBarModel];
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-113);
        viewC.view.frame =rect;
        MainViewController *mainViewC = [[MainViewController alloc]init];
        mainViewC.isRoot = YES;
        mainViewC.startPage = navBarModel.url;
        mainViewC.view.frame = rect;
        [viewC.view addSubview:mainViewC.view];
        [viewC addChildViewController:mainViewC];
        [mainViewC didMoveToParentViewController:viewC];
        viewC.CurrentChildVC = mainViewC;
        mainViewC.isChild = YES;
        UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewC];
        navC.navigationBar.translucent = NO;
        navC.navigationBar.hidden = NO;
        UITabBarItem *tabItem = [self tabBarItemWithModle:tabModel titleColor:nil];
        navC.tabBarItem = tabItem;
        [controllers addObject:navC];
    }
    self.viewControllers = controllers;
    self.tabBarController.tabBar.translucent = NO;
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
//    self.tabBarController.tabBar.barTintColor = [UIColor colorWithHexString:@"F9F9F9"];
//    self.tabBar.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
}


-(UITabBarItem *)tabBarItemWithModle:(SYTabbarModel*)tabModel titleColor:(UIColor*)titleColor{
   
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:tabModel.name image:[self renderImageWithName:[tabModel.ico stringByAppendingString:@"Normal"]] selectedImage:[self renderImageWithName:[tabModel.ico stringByAppendingString:@"Selected"]]];
    tabBarItem.tag = [tabModel.ID integerValue];
    //改变tabBar字体颜色
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"666666"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return tabBarItem;

}

- (UIImage*)renderImageWithName:(NSString*)imageName {
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
