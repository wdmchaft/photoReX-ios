//
//  AccountsUIViewController.m
//  photoReX
//
//  Created by Ali Nouri on 11/12/11.
//  Copyright (c) 2011 Rutgers. All rights reserved.
//

#import "AccountsUIViewController.h"
#import "AccountManager.h"
#import "AccountTableViewCell.h"
#import "FlickrAccountUIViewController.h"

@implementation AccountsUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma -mark TableView delegate functions 

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Account* account = [[AccountManager standardAccountManager] getAccountAtIndex:indexPath.row]; 
    
    CGRect frame = CGRectMake(0, 0, 320, 60); 
    
    
    AccountTableViewCell *cell = (AccountTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[AccountTableViewCell alloc] initWithFrame:frame andAccount:account] autorelease]; 
    }
    
    // Configure the cell...
    cell.theAccount = account; 
    [cell updateActiveImage]; 
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    UIViewController* detailViewController=nil; 
    
    switch (indexPath.row) {
        case FLICKR_INDEX:
            detailViewController = [[FlickrAccountUIViewController alloc] initWithNibName:@"FlickrAccountUIViewController" bundle:[NSBundle mainBundle]];
            
            ((FlickrAccountUIViewController*)detailViewController).theAccount = [[AccountManager standardAccountManager] flickrAccount] ; 
            
            ((FlickrAccountUIViewController*)detailViewController).delegate = (AccountTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            break;
        
        case INSTAGRAM_INDEX: 
            
            break; 
        case GOOGLE_INDEX: 
           
            
            break;
        default:
            break;
    }
    

    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Accounts"; 
            break;
            
        default:
            break;
    }

    return @""; 
}



@end
