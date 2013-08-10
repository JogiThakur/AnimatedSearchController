//
//  ViewController.h
//  AnimatedSearch
//
//  Created by Jogi on 28/06/12.
//  Copyright (c) 2012 devil.at.work.in.japan@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPSearchBar.h"

@interface ViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray       *monthArray;
    IBOutlet JPSearchBar *searchBar;
    
}

-(NSMutableArray*)monthArray;

@end
