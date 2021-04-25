//
//  TableViewCell.m
//  ModuleAppMain
//
//  Created by ZZG on 2021/4/10.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
     NSArray * sub = self.subviews;
    for (UIView * view in sub) {
        NSLog(@"---");
    }
    
}

@end
