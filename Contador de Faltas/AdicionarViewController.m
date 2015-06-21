//
//  AdicionarViewController.m
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import "AdicionarViewController.h"

@interface AdicionarViewController () <UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *ja; //justified
@property (strong, nonatomic) IBOutlet UITextField *ua; //unjustified
@property (strong, nonatomic) NSMutableArray *classesArray; //classes' names

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

    //Get all classes stored
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *classesDict = [pref objectForKey:@"classes"];
    if (classesDict)
    {
        self.classesArray = [[classesDict allKeys] mutableCopy];
    }
    else
    {
        classesDict = [[NSMutableDictionary alloc] init];
        self.classesArray = [[NSMutableArray alloc] init];
    }
    //add function to dismiss keyboard on tab
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    textField.text = @"";
    return YES;
}

-(BOOL) textFieldShouldEndEditing :(UITextField *)textField{
    if ([textField.text isEqualToString: @""]){
        textField.text = @"0";
    }
    return YES;
}

- (IBAction)add {
    NSInteger row = [self.classPicker selectedRowInComponent:0];
    int jaint = [self.ja.text intValue]; //justified abscences
    int uaint = [self.ua.text intValue]; //unjustified abscences
    //Saving so next time You open the app the values are still there
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    if (![pref objectForKey:@"classes"])
    {
    }
    else
    {
        NSMutableDictionary *classesDict = [[pref objectForKey:@"classes"] mutableCopy];
        NSMutableArray *temp = [[classesDict objectForKey:[self pickerView:self.classPicker titleForRow: row forComponent:0]] mutableCopy];
        temp[0] = [NSNumber numberWithInt:([temp[0] intValue] + jaint)];
        temp[1] = [NSNumber numberWithInt:([temp[1] intValue] + uaint)];
        [classesDict setObject:temp forKey:[self pickerView:self.classPicker titleForRow: row forComponent:0]];
        [pref setObject:classesDict forKey:@"classes"];
        [pref synchronize];
        //update initial page
        [self.delegate updateLabels];
        //go back to previous page
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1; //give components here
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:    (NSInteger)component {
    
    return self.classesArray.count;   //give rows here
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.classesArray objectAtIndex:row];
}

- (void)handleSingleTap
{
    //dismiss keyboard
    [self.ja resignFirstResponder];
    [self.ua resignFirstResponder];
}
    
- (IBAction)cancel {
    //go back to last page
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
