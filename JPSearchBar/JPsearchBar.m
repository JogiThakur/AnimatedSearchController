//
//  JPSearchBar.m
//  AnimatedSearch
//
//  Created by Jogi on 28/06/12.
//  Copyright (c) 2012 devil.at.work.in.japan@gmail.com. All rights reserved.
//

#import "JPSearchBar.h"

@interface JPSearchBar ()

/* Private Getter and Setter methods */
-(UIControl*)searchView;
-(void)setSearchArray:(NSMutableArray*)newSearchArray;
-(void)setSearchView:(UIControl*)newSearchView;

@end


@implementation JPSearchBar


-(UIControl*)searchView
{
    if(!_searchView) {
        /* Configuring SearchView according to UI requirement. search view is UIControl which appear on table view when there is no result to display. On its touch action serach bar will resign from respond.*/
        _searchView = [[UIControl alloc]initWithFrame:CGRectMake(0, 44, self.parentController.tableView.bounds.size.width, self.parentController.tableView.bounds.size.height)];
        [_searchView setBackgroundColor:[UIColor blackColor]];
        [_searchView addTarget:self action:@selector(removeResponderFromTableview) forControlEvents:UIControlEventAllTouchEvents];
        [_searchView setAlpha:0.30];
    }
    
    return _searchView;
}

-(NSMutableArray*)searchArray
{
    if(!_searchArray)
        _searchArray = [[NSMutableArray alloc]init];
    return _searchArray;
}

-(void)setSearchArray:(NSMutableArray*)newSearchArray
{
    _searchArray = nil;
    _searchArray = newSearchArray;
}

-(void)setSearchView:(UIControl*)newSearchView
{
    _searchView = nil;
    _searchView = newSearchView;
}

/* method called when search view is being tapped */
-(void)removeResponderFromTableview
{
    [self resignFirstResponder];
    [[self searchView] removeFromSuperview];
    [self.parentController.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)keyboardWillShow:(NSNotification*)aNotification
{
    [self.parentController.tableView addSubview:[self searchView]];
    [self.parentController.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self resignFirstResponder];
    [[self searchView] removeFromSuperview];
    [self.parentController.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    @autoreleasepool {
        
        NSMutableArray *preArr;
        if([[self searchArray] count]==0 && [self.parentController.tableView numberOfRowsInSection:0]!=0)
            preArr = [[NSMutableArray alloc]initWithArray:self.dataArray copyItems:YES];
        else
            preArr = [[NSMutableArray alloc]initWithArray:[self searchArray] copyItems:YES];
        
        [[self searchArray] removeAllObjects];
        _searching = 1;
        
        NSMutableArray *indexPathArr = [[NSMutableArray alloc]init];
        
        if(searchText.length!=0) {
            
            for(int cnt=0;cnt<[self.dataArray count];cnt++)
                if([[[self.dataArray objectAtIndex:cnt] uppercaseString] rangeOfString: [searchText uppercaseString]].location != NSNotFound)
                    [[self searchArray] addObject:[self.dataArray objectAtIndex:cnt]];
        }
        else {
            
            [[self searchArray] removeAllObjects];
            self.searchArray = nil;
            self.searchArray = [self.dataArray mutableCopy];
            [self resignFirstResponder];
            _searching = 0;
            [[self searchView] removeFromSuperview];
            [self.parentController.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        
        if([[self searchArray] count]>[preArr count]) {   // cell will get added
            
            for (id obj in [self searchArray])
                if(![preArr containsObject:obj])
                    [indexPathArr addObject:[NSIndexPath indexPathForRow:[[self searchArray] indexOfObject:obj] inSection:0]];
            
            [self.parentController.tableView beginUpdates];
            [self.parentController.tableView insertRowsAtIndexPaths:indexPathArr withRowAnimation:UITableViewRowAnimationTop];
            [self.parentController.tableView endUpdates];
        }
        else if ([[self searchArray] count]<[preArr count]) {  // cell will get removed
            
            for (id obj in preArr)
                if(![[self searchArray] containsObject:obj])
                    [indexPathArr addObject:[NSIndexPath indexPathForRow:[preArr indexOfObject:obj] inSection:0]];
            
            [self.parentController.tableView beginUpdates];
            [self.parentController.tableView deleteRowsAtIndexPaths:indexPathArr withRowAnimation:UITableViewRowAnimationTop];
            [self.parentController.tableView endUpdates];
        }
        
        if([[self searchArray] count]==0)
            [self.parentController.tableView addSubview:[self searchView]];
        else
            [[self searchView] removeFromSuperview];
        
        preArr = nil;
        indexPathArr = nil;
    }
}


@end
