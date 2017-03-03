//
//  SYNavigatonBarModel.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/24.
//
//

#import <Foundation/Foundation.h>

@interface SYNavigatonBarModel : NSObject
@property (nonatomic,copy)NSString *url;
@property (nonatomic,strong)NSDictionary *title;
@property (nonatomic,strong)NSArray *leftBtns;
@property (nonatomic,strong)NSArray *rightBtns;
@end
