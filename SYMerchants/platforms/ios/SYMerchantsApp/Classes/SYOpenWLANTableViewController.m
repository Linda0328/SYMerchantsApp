//
//  SYOpenWLANTableViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2017/2/7.
//
//

#import "SYOpenWLANTableViewController.h"
#import "HexColor.h"
#import "UILabel+SYNavTItle.h"
static NSString *noticeWLAN = @"您的设备未连接移动网络，或wi-fi网络";
static NSString *WIFI = @"在设备的【设置>无线局域网】请选择一个wi-fi热点连接";
static NSString *DataTriffic = @"在设备的【设置>蜂窝移动网络】中启用蜂窝移动数据";
static NSString *jurisdiction = @"iOS10及以上系统，如果其他软件可以使用网络，请检查是否打开唯品会上网权限？";
static NSString *OpenJurisdictionMethod = @"在设备的【设置>蜂窝移动网络>使用无线网络与蜂窝移动应用】中找到商家APP勾选【无线局域网与蜂窝移动数据】即可";
@interface SYOpenWLANTableViewController ()

@end

@implementation SYOpenWLANTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"F9F9F9"];
    UILabel *titleLab = [UILabel navTitle:@"网络说明" TitleColor:[UIColor colorWithHexString:@"333333"] titleFont:[UIFont systemFontOfSize:20]];
    self.navigationItem.titleView = titleLab;
    UIImage *image = [UIImage imageNamed:@"btn_back"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
//    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = item;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 48)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    CGSize size = [noticeWLAN sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UILabel *noticeL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    noticeL.text = noticeWLAN;
    noticeL.textColor = [UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0];
    noticeL.textAlignment = NSTextAlignmentLeft;
    noticeL.font = [UIFont systemFontOfSize:14];
    noticeL.center = view.center;
    [view addSubview:noticeL];
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = [[UIView alloc]init];

}
-(void)back:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)checkJurisdiction:(UIButton*)button{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
            }];
        }
    }
    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >=8) {
        NSString *urlStr = [NSString stringWithFormat:@"prefs:root=%@",bundleID];
        NSURL *url =[NSURL URLWithString:urlStr];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 4;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0f;
    }
     return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        if (indexPath.section == 0) {
            CGSize size = [WIFI boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame)-30, 60) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            return size.height+35;
        }
        if (indexPath.section == 1) {
            CGSize size = [DataTriffic boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame)-30, 60) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            return size.height+35;
        }
        if (indexPath.section == 2) {
            CGSize size = [jurisdiction boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame)-30, 60) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            return size.height+35;
        }
    }
    if (indexPath.row == 2) {
        CGSize size = [OpenJurisdictionMethod boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame)-30, 60) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        return size.height+35+20;
    }
    if (indexPath.row == 3) {
        return 60;
    }
    return 48;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WLANIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (indexPath.row ==2) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }else{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    }

    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"444444"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    if (indexPath.row == 1) {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        NSInteger lineNum = (cell.frame.size.height - 35)/13;
        cell.textLabel.numberOfLines = lineNum;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"wi-fi网络请参照下面方法:";
        }
        if (indexPath.row == 1) {
            NSString *keyW = @"【设置>无线局域网】";
            NSMutableAttributedString *cellA = [[NSMutableAttributedString alloc]initWithString:WIFI];
            [cellA addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"444444"]} range:[WIFI rangeOfString:keyW]];
            cell.textLabel.attributedText = cellA;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"蜂窝数据请参照下面方法:";
        }
        if (indexPath.row == 1) {
        
            NSString *keyW = @"【设置>蜂窝移动网络】";
            NSMutableAttributedString *cellA = [[NSMutableAttributedString alloc]initWithString:DataTriffic];
            [cellA addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"444444"]} range:[DataTriffic rangeOfString:keyW]];
            cell.textLabel.attributedText = cellA;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"检查网络权限是否打开:";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = jurisdiction;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"查看方法:";
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999999"];
            NSInteger lineNum = (cell.frame.size.height - 35)/13;
            cell.detailTextLabel.numberOfLines = lineNum;
            NSString *keyW = @"【设置>蜂窝移动网络>使用无线网络与蜂窝移动应用】";
            NSString *keyW0 = @"【无线局域网于蜂窝移动数据】";
            NSMutableAttributedString *cellA = [[NSMutableAttributedString alloc]initWithString:OpenJurisdictionMethod];
            [cellA addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"444444"]} range:[OpenJurisdictionMethod rangeOfString:keyW]];
            [cellA addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"444444"]} range:[OpenJurisdictionMethod rangeOfString:keyW0]];
            cell.detailTextLabel.attributedText = cellA;
        }
    }
    if (indexPath.row == 3) {
        CGSize size0 = CGSizeMake(117, 40);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGRect Buttonrect = CGRectMake(width/2-size0.width/2, 10, size0.width, size0.height);
        UIButton *refreshBut = [[UIButton alloc]initWithFrame:Buttonrect];
        [refreshBut setTitle:@"查看权限" forState:UIControlStateNormal];
        UIColor *buttonColor = [UIColor colorWithHexString:@"444444"];
        [refreshBut setTitleColor:buttonColor forState:UIControlStateNormal];
        refreshBut.layer.cornerRadius = 10.0f;
        refreshBut.layer.borderColor = buttonColor.CGColor;
        refreshBut.layer.borderWidth = 1.0f;
        [refreshBut addTarget:self action:@selector(checkJurisdiction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:refreshBut];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
