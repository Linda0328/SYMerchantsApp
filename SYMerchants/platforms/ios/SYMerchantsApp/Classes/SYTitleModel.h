//
//  SYTitleModel.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/12/27.
//
//

#import <Foundation/Foundation.h>
extern NSString *const titleType;
extern NSString *const imageType;
extern NSString *const searchType;
extern NSString *const optionType;
@interface SYTitleModel : NSObject
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)NSDictionary *value;
@end
