//
//  ContaFaltasViewController.m
//  Contador de Faltas
//
//  Created by Fábio Gelbcke Work on 2/17/14.
//  Copyright (c) 2014 Tilsix. All rights reserved.
//

#import "ContaFaltasViewController.h"

#import "ContaFaltasCell.h"


@interface ContaFaltasViewController ()
@property (strong, nonatomic) IBOutlet UILabel *points;
@property (strong, nonatomic) IBOutlet UITableView *classesTable;
@property (strong, nonatomic) NSMutableArray *classesArray;
@property (strong, nonatomic) NSDictionary *classesDict;

@end

@implementation ContaFaltasViewController{
    
    NSUserDefaults* prefs;
    int n;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    //Dictionario com os cursos
    NSMutableDictionary *classes= [[pref objectForKey:@"classes"] mutableCopy];
    if (!classes)
        classes = [[NSMutableDictionary alloc] init];
    [pref setObject:classes forKey:@"classes"];
    [pref synchronize];
    self.classesArray = [[classes allKeys] mutableCopy];
    self.classesDict = [classes mutableCopy];
    [self.classesTable reloadData];
    [self updateLabels];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classesArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier= @"Cell";
    ContaFaltasCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ContaFaltasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.nameOfClass.text = [self.classesArray objectAtIndex:indexPath.row];
    int totalClasses = [[self.classesDict objectForKey:[self.classesArray objectAtIndex:indexPath.row]][2] intValue];
    int just = [[self.classesDict objectForKey:[self.classesArray objectAtIndex:indexPath.row]][0] intValue];
    int unjust = [[self.classesDict objectForKey:[self.classesArray objectAtIndex:indexPath.row]][1] intValue];
    if (totalClasses == 0){
        cell.percent.text = @"-";
    }
    else{
        int percentage = (100.0 * (just + unjust)) / totalClasses;
        cell.percent.text = [NSString stringWithFormat:@"%d%%",percentage];
        if(percentage<=10){
            cell.percent.textColor = [UIColor greenColor];
        }
        else if (percentage<=20){
            cell.percent.textColor = [UIColor yellowColor];
        }
        else{
            cell.percent.textColor = [UIColor redColor];
        }
    }
    cell.absratio.text = [NSString stringWithFormat:@"%d/%d",just,unjust];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *updatedSubjects = [self.classesDict mutableCopy];
        [updatedSubjects removeObjectForKey:[self.classesArray objectAtIndex:indexPath.row]];
        [pref setObject:updatedSubjects forKey:@"classes"];
        [self updateLabels]; // tell table to refresh now
    }
}

- (IBAction)add:(UIBarButtonItem *)sender {
    //Load and show screen to add abscences
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    AdicionarViewController *addController = (AdicionarViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Add"];
    addController.delegate=self;
    NSMutableArray *numberArray = [[NSMutableArray alloc] init];
    int i=0;
    for (i=0; i<n; i++){
        [numberArray addObject:[NSString stringWithFormat:@"%d",i]];
        NSLog(@"a");
    }
    addController.classPicker = [[UIPickerView alloc] init];
    addController.numberOfElements = [NSNumber numberWithInt:n];
    [self presentViewController:addController animated:YES completion:nil];

    
    
}
- (IBAction)edit:(UIBarButtonItem *)sender {
    
    
}
- (IBAction)newClass {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    MateriaViewController *newClassController = (MateriaViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NewClass"];
    newClassController.delegate = self;
    [self presentViewController:newClassController animated:YES completion:nil];
    
}

-(void)updateLabels{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    //Dictionario com os cursos
    NSMutableDictionary *classes= [[pref objectForKey:@"classes"] mutableCopy];
    self.classesArray = [[classes allKeys] mutableCopy];
    self.classesDict = [classes mutableCopy];
    int totalPoints = 0;
    for (NSString *class in self.classesArray)
    {
        totalPoints += [[self.classesDict objectForKey:class][0] intValue];
        totalPoints += 3 * [[self.classesDict objectForKey:class][1] intValue];
    }
    self.points.text = [NSString stringWithFormat:@"%d",totalPoints];
    if (totalPoints<60){
        self.points.textColor = [UIColor greenColor];
    }
    else if (totalPoints<90){
        self.points.textColor = [UIColor yellowColor];
    }
    else {
        self.points.textColor = [UIColor redColor];
    }
    //update table
    [self.classesTable reloadData];
    
}

@end
