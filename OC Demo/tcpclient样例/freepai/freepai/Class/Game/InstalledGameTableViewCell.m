//
//  InstalledGameTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "InstalledGameTableViewCell.h"

@implementation InstalledGameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.installedGameScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
        self.installedGameScrollView.backgroundColor = [UIColor clearColor];
        self.installedGameScrollView.showsHorizontalScrollIndicator = NO;
        self.installedGameScrollView.showsVerticalScrollIndicator = NO;
        //scrollView.delegate = self;
        [self addSubview: self.installedGameScrollView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
