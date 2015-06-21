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

- (void)handleSingleTap
{
    [self.subject resignFirstResponder];
    [self.totalHours resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //add function to dismiss keyboard on tab
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add {
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *classes= [[pref objectForKey:@"classes"] mutableCopy];
    if (!classes)
        classes = [[NSMutableDictionary alloc] init];
    if ([classes objectForKey:self.subject.text])
    {
        //IF SUBJECT ALREADY EXISTS
    }
    else
    {
        // IF SUBJECT DOESNT EXIST CREATE ARRAY WITH 3 values, two 0's for the abscences (justified and not) and the total number of classes.
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:[self.totalHours.text intValue]], nil];
        [classes setObject:temp forKey:self.subject.text];
        [pref setObject:classes forKey:@"classes"];
        [pref synchronize];
     //   [self.delegate addItemViewController:self didFinishEntering:self.subject.text withHours:[self.totalHours.text intValue]];
        //update initial page and go back
        [self.delegate updateLabels];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
//go back to main screen
}

@end
