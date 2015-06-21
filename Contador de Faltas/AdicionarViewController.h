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

- (void)updateLabels;

@end

@interface AdicionarViewController : UIViewController

@property (nonatomic, weak) id <AdicionarDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIPickerView *classPicker;
@property NSNumber *numberOfElements;

@end
