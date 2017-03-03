//
//  UILabel+SYNavTItle.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/29.
//
//

#import "UILabel+SYNavTItle.h"

@implementation UILabel (SYNavTItle)
+(UILabel*)navTitle:(NSString*)title TitleColor:(UIColor*)color titleFont:(UIFont*)font{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 0)];
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = font;
    titleLab.textColor = color;
    titleLab.numberOfLines = 0;
    [titleLab sizeToFit];
    return titleLab;
}
@end
