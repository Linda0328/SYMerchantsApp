//
//  SYMainModel.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/23.
//
//

#import <Foundation/Foundation.h>

@interface SYMainModel : NSObject
@property (nonatomic,copy)NSString *url;
@property (nonatomic,strong)NSDictionary *title;
@property (nonatomic,strong)NSArray *leftBtns;
@property (nonatomic,strong)NSArray *rightBtns;
@property (nonatomic,strong)NSArray *bottomBtns;
@end
