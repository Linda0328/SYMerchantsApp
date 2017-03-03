//
//  SYNavViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import "SYNavViewController.h"
#import "MainViewController.h"
#import "HexColor.h"
#import "UILabel+SYNavTItle.h"
#import "SYNavigationItemModel.h"
#import "SYEventButton.h"
@interface SYNavViewController ()

@end

@implementation SYNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"F9F9F9"];
    UILabel *titleLab = [UILabel navTitle:self.navBarModel.title TitleColor:[UIColor colorWithHexString:@"333333"] titleFont:[UIFont systemFontOfSize:20]];
    self.navigationItem.titleView = titleLab;
    if ([self.navBarModel.leftBtns count]>0) {
        NSMutableArray *leftItems = [NSMutableArray array];
        for (SYNavigationItemModel *itemM in self.navBarModel.leftBtns){
            SYEventButton *eventB = [[SYEventButton alloc]init];
            eventB.model = itemM;
            [eventB addTarget:self action:@selector(EventAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:eventB];
            [leftItems addObject:item];
        }
        self.navigationItem.leftBarButtonItems = leftItems;
    }
    if ([self.navBarModel.rightBtns count]>0) {
         NSMutableArray *rightItems = [NSMutableArray array];
        for (SYNavigationItemModel *itemM in self.navBarModel.rightBtns) {
            SYEventButton *eventB = [[SYEventButton alloc]init];
            eventB.model = itemM;
            [eventB addTarget:self action:@selector(EventAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:eventB];
            [rightItems addObject:item];
        }
        self.navigationItem.rightBarButtonItems = rightItems;
    }
}
//-(void)EventAction:(SYEventButton*)eventB{
//    if (![SYGlobleConst judgeNSString:eventB.event]) {
//        return;
//    }
//    
//}
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
