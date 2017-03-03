//
//  SYEventButton.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/27.
//
//

#import "SYEventButton.h"
#import "HexColor.h"
static CGFloat font = 17.0f;
@implementation SYEventButton
-(void)setModel:(SYNavigationItemModel *)model{
    _model = model;
    self.tag = [model.ID integerValue];
    if ([SYGlobleConst judgeNSString:model.name]&&![SYGlobleConst judgeNSString:model.ico]) {
        
        CGSize size = [model.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
        self.frame = CGRectMake(0, 0, size.width, size.height);
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:model.name forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    }
    if (![SYGlobleConst judgeNSString:model.name]&&[SYGlobleConst judgeNSString:model.ico]) {
        UIImage *image = [UIImage imageNamed:model.ico];
        CGFloat width = image.size.width>39?image.size.width:40;
        CGFloat height = image.size.height>39?image.size.height:40;
        self.frame = CGRectMake(0, 0, width, height);
        [self setImage:image forState:UIControlStateNormal];
    }
    if ([SYGlobleConst judgeNSString:model.name]&&![SYGlobleConst judgeNSString:model.ico]) {
       
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
