//
//  SYReachableNotViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2017/2/4.
//
//

#import "SYReachableNotViewController.h"
#import "SYIntroduceWLANView.h"
#import "SYOpenWLANTableViewController.h"
#import "HexColor.h"
#import "UILabel+SYNavTItle.h"
static NSString *noLANNotice = @"网络无法链接";
static NSString *refresh = @"点击刷新";
@interface SYReachableNotViewController ()

@end

@implementation SYReachableNotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"F9F9F9"];
    UILabel *titleLab = [UILabel navTitle:@"网络提示" TitleColor:[UIColor colorWithHexString:@"333333"] titleFont:[UIFont systemFontOfSize:20]];
    self.navigationItem.titleView = titleLab;
    // Do any additional setup after loading the view.
    SYIntroduceWLANView *introductV = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SYIntroduceWLANView class]) owner:nil options:nil] firstObject];
    CGRect introRect = introductV.frame;
    introRect.origin.y = 64;
    introRect.size.width = CGRectGetWidth(self.view.frame);
    introductV.frame = introRect;
    introductV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOpenWLAN:)];
    [introductV addGestureRecognizer:tap];
    [self.view addSubview:introductV];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = [noLANNotice sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UILabel *noticeL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    noticeL.text = noLANNotice;
    noticeL.center = self.view.center;
    noticeL.font = [UIFont systemFontOfSize:14.0f];
    noticeL.textColor = [UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0];
    noticeL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noticeL];
    
    UIImage *LANImage = [UIImage imageNamed:@"noneLAN"];
    CGRect rect = CGRectMake(CGRectGetWidth(self.view.frame)/2-LANImage.size.width/2, CGRectGetMinY(noticeL.frame)-18.0-LANImage.size.height, LANImage.size.width, LANImage.size.height);
    UIImageView *lanImgV = [[UIImageView alloc]initWithFrame:rect];
    [lanImgV setImage:LANImage];
    [self.view addSubview:lanImgV];
    
    CGSize Buttonsize = CGSizeMake(117, 40);
    CGRect Buttonrect = CGRectMake(CGRectGetWidth(self.view.frame)/2-Buttonsize.width/2, CGRectGetMaxY(noticeL.frame)+18.0, Buttonsize.width, Buttonsize.height);
    UIButton *refreshBut = [[UIButton alloc]initWithFrame:Buttonrect];
    [refreshBut setTitle:refresh forState:UIControlStateNormal];
    UIColor *buttonColor = [UIColor colorWithRed:153.0f/255.0 green:153.0f/255.0 blue:153.0f/255.0 alpha:1.0f];
    [refreshBut setTitleColor:buttonColor forState:UIControlStateNormal];
    refreshBut.layer.cornerRadius = 10.0f;
    refreshBut.layer.borderColor = buttonColor.CGColor;
    refreshBut.layer.borderWidth = 1.0f;
    [refreshBut addTarget:self action:@selector(ReFresh:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBut];
}
-(void)ReFresh:(UIButton*)but{
    if (self.refreshB) {
        self.refreshB();
    }
}
-(void)showOpenWLAN:(UITapGestureRecognizer*)tap{
    SYOpenWLANTableViewController *openL = [[SYOpenWLANTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
//    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//    [self presentViewController:openL animated:YES completion:nil];
    [self.navigationController pushViewController:openL animated:YES];
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
