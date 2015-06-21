//
//  ContaFaltasCell.h
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContaFaltasCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameOfClass;
@property (strong, nonatomic) IBOutlet UILabel *percent;
@property (strong, nonatomic) IBOutlet UILabel *absratio;


@end
