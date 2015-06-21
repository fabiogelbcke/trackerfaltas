//
//  MateriaViewController.m
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import "MateriaViewController.h"



@interface MateriaViewController ()
@property (strong, nonatomic) IBOutlet UITextField *subject;
@property (strong, nonatomic) IBOutlet UITextField *totalHours;

@end

@implementation MateriaViewController

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
    [self.delegate addItemViewController:self didFinishEntering:self.subject.text withHours:[self.totalHours.text intValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end
