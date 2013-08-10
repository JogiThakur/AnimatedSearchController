//
//  JPSearchBar.h
//  AnimatedSearch
//
//  Created by Jogi on 28/06/12.
//  Copyright (c) 2012 devil.at.work.in.japan@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPSearchBar : UISearchBar <UISearchBarDelegate>{
    
// pls dont use private api 
@private
    NSMutableArray  *_searchArray;
    UIControl   *_searchView;
}

/* Returns array which contains searched objects.*/
-(NSMutableArray*)searchArray;

/* TableView Controller which is being searched. */
@property(nonatomic,weak) UITableViewController  *parentController;
/* your data array which need to be searched in tableview. */
@property(nonatomic,weak) NSMutableArray         *dataArray;
/* boolean that shows currently searching is on or off (ReadOnly). */
@property(nonatomic,readonly,getter=isSearching)  BOOL searching;

@end
