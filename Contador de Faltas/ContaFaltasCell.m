//
//  ContaFaltasCell.m
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import "ContaFaltasCell.h"

@implementation ContaFaltasCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameOfClass = [[UILabel alloc] init];
        self.percent =[[UILabel alloc] init];
        [self.contentView addSubview:self.percent];
        [self.contentView addSubview:self.nameOfClass];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
