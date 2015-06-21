//
//  AdicionarViewController.m
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import "AdicionarViewController.h"

@interface AdicionarViewController ()
@property (strong, nonatomic) IBOutlet UITextField *ja;
@property (strong, nonatomic) IBOutlet UITextField *ua;


@end

@implementation AdicionarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add {
    
    NSInteger row = [self.classPicker selectedRowInComponent:0];
    int ja = [self.ja.text intValue];
    int ua = [self.ja.text intValue];
    [self.delegate AddViewController:self JustifiedAbsences:ja andUnjustified:ua forClass:row];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1; //give components here
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:    (NSInteger)component {
    
    return 2;   //give rows here
}
- (IBAction)cancel {
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
