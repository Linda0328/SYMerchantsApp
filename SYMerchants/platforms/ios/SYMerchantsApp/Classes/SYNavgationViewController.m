//
//  SYNavgationViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/12/28.
//
//

#import "SYNavgationViewController.h"
#import "SYTitleModel.h"
#import "SYOptionModel.h"
#import "HexColor.h"
#import "UILabel+SYNavTItle.h"
#import "SYNavigationItemModel.h"
#import "SYEventButton.h"
#import "SYScanViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
@interface SYNavgationViewController ()<UIAlertViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)SYTitleModel *titleModel;
@property (nonatomic,strong)NSMutableArray *optionURLArr;

@end

@implementation SYNavgationViewController
+(SYNavgationViewController*)initWithFrame:(CGRect)rect{
    SYNavgationViewController *vc = [[SYNavgationViewController alloc]init];
    vc.view.frame = rect;
    return vc;
}
- (void)viewWillAppear:(BOOL)animated
{
    // you can do so here.
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    __weak __typeof(self)weakSelf = self;
    self.pushBlock = ^(NSString *contentUrl,BOOL isBackToLast,SYNavigatonBarModel *navModel){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        SYNavgationViewController *viewC =[[SYNavgationViewController alloc]init];
        [viewC setNavigationBar:navModel];
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
        viewC.view.frame = rect;
        viewC.isBackToLast = isBackToLast;
        MainViewController *pushM = [[MainViewController alloc]init];
        pushM.startPage = navModel.url;
        viewC.CurrentChildVC = pushM;
        pushM.view.frame = viewC.view.bounds;
        [viewC addChildViewController:pushM];
        [viewC.view addSubview:pushM.view];
        [pushM didMoveToParentViewController:viewC];
        pushM.isChild = YES;
        pushM.isRoot = NO;
        pushM.lastViewController = strongSelf.CurrentChildVC;
        strongSelf.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:viewC animated:YES];
        if (strongSelf.CurrentChildVC.isRoot) {
            strongSelf.hidesBottomBarWhenPushed = NO;
        }
        
    };
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(PushScanVC:) name:scanNotify object:nil];
    [center addObserver:self selector:@selector(popVC:) name:popNotify object:nil];
}

-(void)PushScanVC:(NSNotification*)notify{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
//        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未允许app访问相机，无法进进入扫一扫，前往打开权限？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
//        [alertV show];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未允许app访问相机，无法进入扫一扫，前往设置-隐私-相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >=8) {
                NSString *urlStr = [NSString stringWithFormat:@"prefs:root=%@",bundleID];
                NSURL *url =[NSURL URLWithString:urlStr];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
                    }];
                }
            }

//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"]];
        }];
        
//        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:cancelAction];
        [alertC addAction:confirmAction];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    MainViewController *main = (MainViewController*)notify.object;
    if (![main isEqual:_CurrentChildVC]) {
        return;
    }
    SYScanViewController *scan = [[SYScanViewController alloc]init];
    scan.lastMain = _CurrentChildVC;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scan animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)popVC:(NSNotification*)notify{
    
    MainViewController *main = (MainViewController*)notify.object;
    if (![main isEqual:_CurrentChildVC]) {
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setNavigationBar:(SYNavigatonBarModel *)navBarModel{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"F9F9F9"];
    [SYTitleModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    _titleModel = [SYTitleModel objectWithKeyValues:navBarModel.title];
    if ([_titleModel.type isEqualToString:titleType]) {
        UILabel *titleLab = [UILabel navTitle:[_titleModel.value objectForKey:_titleModel.type] TitleColor:[UIColor colorWithHexString:@"333333"] titleFont:[UIFont systemFontOfSize:20]];
        self.navigationItem.titleView = titleLab;
        titleLab.tag = [_titleModel.ID integerValue];
    }else if ([_titleModel.type isEqualToString:imageType]){
        UIImage *titleImage = [UIImage imageNamed:_titleModel.value[_titleModel.type]];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
        imageV.image = titleImage;
        self.navigationItem.titleView = imageV;
        imageV.tag = [_titleModel.ID integerValue];;
    }else if ([_titleModel.type isEqualToString:searchType]){
        UISearchBar *searchB = [[UISearchBar alloc]init];
        searchB.text = _titleModel.value[_titleModel.type];
        searchB.delegate = self;
        self.navigationItem.titleView = searchB;
        searchB.tag = [_titleModel.ID integerValue];
    }else if ([_titleModel.type isEqualToString:optionType]){
        _optionURLArr = [NSMutableArray array];
        NSMutableArray *titleArr = [NSMutableArray array];
        NSInteger select = 0;
        for (NSInteger i = 0; i < [_titleModel.value[_titleModel.type] count]; i++) {
            SYOptionModel *model = [SYOptionModel objectWithKeyValues:_titleModel.value[_titleModel.type][i]];
            [_optionURLArr addObject:model.url];
            if (model.select) {
                select = i;
            }
            [titleArr addObject:model.name];
        }
        UISegmentedControl *segMent = [[UISegmentedControl alloc]initWithItems:titleArr];
        segMent.selectedSegmentIndex = select;
        CGRect frame = segMent.frame;
        frame = CGRectMake(0, 0,self.view.bounds.size.width/2, 30);
        segMent.frame = frame;
        [segMent addTarget:self action:@selector(clickedSegmented:) forControlEvents:UIControlEventValueChanged];
        segMent.tag = [_titleModel.ID integerValue];
        self.navigationItem.titleView.tintColor = [UIColor whiteColor];
        self.navigationItem.titleView = segMent;
    }
    
    if ([navBarModel.leftBtns count]>0) {
        NSMutableArray *leftItems = [NSMutableArray array];
        for (NSDictionary *dic in navBarModel.leftBtns){
            SYNavigationItemModel *itemM = [SYNavigationItemModel objectWithKeyValues:dic];
            SYEventButton *eventB = [[SYEventButton alloc]init];
            eventB.model = itemM;
            [eventB addTarget:self action:@selector(EventAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:eventB];
            [leftItems addObject:item];
        }
        UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
        [leftItems addObject:negativeSpacer];
        self.navigationItem.leftBarButtonItems = leftItems;
    }
    if ([navBarModel.rightBtns count]>0) {
        NSMutableArray *rightItems = [NSMutableArray array];
        for (NSDictionary *dic in navBarModel.rightBtns) {
            SYNavigationItemModel *itemM = [SYNavigationItemModel objectWithKeyValues:dic];
            SYEventButton *eventB = [[SYEventButton alloc]init];
            eventB.model = itemM;
            [eventB addTarget:self action:@selector(EventAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:eventB];
            [rightItems addObject:item];
        }
        self.navigationItem.rightBarButtonItems = rightItems;
    }
}
-(void)clickedSegmented:(UISegmentedControl*)segment{
    NSString *selectedUrl = [_optionURLArr objectAtIndex:segment.selectedSegmentIndex];
    [self.CurrentChildVC LoadURL:selectedUrl];
}
-(void)EventAction:(SYEventButton*)eventB{
    if ([eventB.model.type isEqualToString:@"back"]) {
        if (_isBackToLast) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
            if (index-2<0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                return;
            }
            UIViewController *VC =[self.navigationController.viewControllers objectAtIndex:index-2];
            [self.navigationController popToViewController:VC animated:YES];
        }
        return;
    }

    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *event = [userDef objectForKey:eventB.model.ID];
    eventB.event = event;
    if (![SYGlobleConst judgeNSString:eventB.event]) {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:nil message:@"稍等片刻~~" delegate:self cancelButtonTitle:@"谢谢等待^_^" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }
    
    if ([eventB.event hasPrefix:@"javascript:"]) {
        NSString *newEvent = [eventB.event stringByReplacingOccurrencesOfString:@"javascript:" withString:@""];
        if ([eventB.event hasSuffix:@";"]) {
            newEvent = [newEvent substringToIndex:[newEvent length]-1];
        }
        [self.CurrentChildVC.commandDelegate evalJs:[newEvent stringByAppendingString:@"()"]];
    }else{
        [self.CurrentChildVC LoadURL:eventB.event];
    }
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
