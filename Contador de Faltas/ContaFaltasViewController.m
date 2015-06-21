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
@property (strong, nonatomic) NSMutableArray *justifiedArray;
@property (strong, nonatomic) NSMutableArray *totalHoursArray;
@property (strong, nonatomic) NSMutableArray *unjustifiedArray;

@end

@implementation ContaFaltasViewController{
    
    NSUserDefaults* prefs;
    int n;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.classesArray = [[NSMutableArray alloc] init];
    self.totalHoursArray = [[NSMutableArray alloc] init];
    self.justifiedArray = [[NSMutableArray alloc] init];
    self.unjustifiedArray = [[NSMutableArray alloc] init];
    [self.classesTable reloadData];
    prefs= [NSUserDefaults standardUserDefaults];
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!n) n=0;
    return n;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog([NSString stringWithFormat:@"para %ld : %@",(long)indexPath.row, [self.classesArray objectAtIndex:indexPath.row]]);
    static NSString *CellIdentifier= @"Cell";
    
    ContaFaltasCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ContaFaltasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.nameOfClass.text = [self.classesArray objectAtIndex:indexPath.row];
    if ([[self.totalHoursArray objectAtIndex:indexPath.row] intValue]==0){
        cell.percent.text = @"-";
    }
    else{
        int percentage = ([(NSString *)[self.unjustifiedArray objectAtIndex:indexPath.row] intValue] + [(NSString *)[self.justifiedArray objectAtIndex:indexPath.row] intValue])/[(NSString *)[self.totalHoursArray objectAtIndex:indexPath.row] intValue];
        cell.percent.text = [NSString stringWithFormat:@"%d%%",percentage];
        if(percentage<50){
            cell.percent.textColor = [UIColor greenColor];
        }
        else if (percentage<75){
            cell.percent.textColor = [UIColor yellowColor];
        }
        else{
            cell.percent.textColor = [UIColor redColor];
        }
    }

    return cell;
}
- (void)addItemViewController:(MateriaViewController *)controller didFinishEntering:(NSString *)Class withHours:(int)hours{
    if (!n) n=0;
    n++;

    [self.classesArray addObject:Class];
    [self.totalHoursArray addObject:[NSString stringWithFormat:@"%d",hours]];
    [self.unjustifiedArray addObject:@"0"];
    [self.justifiedArray addObject:@"0"];
    [self updateLabels];
    
    
}

-(void)AddViewController:(AdicionarViewController *)viewController JustifiedAbsences:(int)ja andUnjustified:(int)ua forClass:(NSInteger)class{
    
    ContaFaltasCell *cell = (ContaFaltasCell *)[self.classesTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:class inSection:0]];
    int unjustified = [(NSString*)[self.unjustifiedArray objectAtIndex:class] intValue]+ ua;
    int justified = [(NSString *)[self.justifiedArray objectAtIndex:class]intValue] + ja;
    [self.justifiedArray replaceObjectAtIndex:class withObject:[NSString stringWithFormat:@"%d",justified]];
    [self.unjustifiedArray replaceObjectAtIndex:class withObject:[NSString stringWithFormat:@"%d",unjustified]];
    [self updateLabels];
}
- (IBAction)add:(UIBarButtonItem *)sender {
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
    [addController.classPicker setValuesForKeysWithDictionary:[NSDictionary dictionaryWithObjects:self.classesArray forKeys:numberArray]];
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
    
    int totalPoints = 0;
    int i;
    for (i=0; i<[self.unjustifiedArray count]; i++){
        totalPoints+=3*[[self.unjustifiedArray objectAtIndex:i] intValue];
        totalPoints+=[[self.justifiedArray objectAtIndex:i] intValue];
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
    [self.classesTable reloadData];
    
}

@end
