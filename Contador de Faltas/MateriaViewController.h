//
//  MateriaViewController.h
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MateriaViewController;

@protocol MateriaViewControllerDelegate <NSObject>
@required
- (void)updateLabels;
@end

@interface MateriaViewController : UIViewController
@property (nonatomic, weak) id <MateriaViewControllerDelegate> delegate;
@end
