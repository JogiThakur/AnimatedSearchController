//
//  ViewController.m
//  AnimatedSearch
//
//  Created by Jogi on 28/06/12.
//  Copyright (c) 2012 devil.at.work.in.japan@gmail.com. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    monthArray = [[NSMutableArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    /* setting some properties to searchbar object(Required).*/
    [searchBar setParentController:self];
    [searchBar setDataArray:monthArray];
    [searchBar setDelegate:searchBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* Adding searchbar object as observer to notifiaction center to get keyboard event(Required).*/
    [[NSNotificationCenter defaultCenter] addObserver:searchBar selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    /* Removing object on disappear. */
    [[NSNotificationCenter defaultCenter] removeObserver:searchBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self monthArray] count];
}

/* return's data array, if searching is on then main array if not then search array(Required). */
-(NSMutableArray*)monthArray
{
    if(searchBar.isSearching==1)
        return searchBar.searchArray;
    else
        return monthArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellId];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    
    [cell.textLabel setText:[[self monthArray] objectAtIndex:indexPath.row]];
    return cell;
}

@end
