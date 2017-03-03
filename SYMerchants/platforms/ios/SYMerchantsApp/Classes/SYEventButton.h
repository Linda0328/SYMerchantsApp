//
//  SYEventButton.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/27.
//
//

#import <UIKit/UIKit.h>
#import "SYNavigationItemModel.h"
@interface SYEventButton : UIButton
@property (nonatomic,copy)NSString *event;
@property (nonatomic,strong)SYNavigationItemModel *model;

@end
