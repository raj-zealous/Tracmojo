//
//  SelectedEmailFromContact.h
//  Tracmojo
//
//  Created by macmini3 on 13/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedEmailFromContact : UIViewController<UISearchBarDelegate>
{
    IBOutlet UITableView *tableEmail;
    IBOutlet UIButton *btn_Done;
    NSMutableDictionary *dicContact;
    IBOutlet UISearchBar *search;
    BOOL isSearching;
    NSMutableArray *tempArray;
  //  NSMutableArray *emailArray;
}
@property(strong,nonatomic)NSMutableArray *dic_email;
@end
