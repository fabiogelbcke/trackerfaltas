//
//  AdicionarViewController.h
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdicionarViewController;

@protocol AdicionarDelegate <NSObject, UIPickerViewDelegate>

-(void)AddViewController: (AdicionarViewController *)viewController JustifiedAbsences: (int)ja andUnjustified: (int)ua forClass:(NSInteger)class;

@end

@interface AdicionarViewController : UIViewController

@property (nonatomic, weak) id <AdicionarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *classPicker;
@property NSNumber *numberOfElements;

@end
