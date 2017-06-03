//
//  QDMyListCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CellType) {
    CellTypeHistory,
    CellTypeMessage,
    CellTypeHelp,
    CellTypeService,
    CellTypeForm
};

@interface QDMyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLabel;
@property (nonatomic, assign) CellType cellType;
@end
