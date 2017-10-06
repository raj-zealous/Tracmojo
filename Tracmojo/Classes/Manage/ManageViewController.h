//
//  ManageViewController.h
//  Tracmojo
//
//  Created by Peerbits Solution on 14/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "ModelClass.h"
#import "SWTableViewCell.h"

@interface ManageViewController : UIViewController<SWTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>


@property (nonatomic, weak) IBOutlet SKSTableView *tableView;
@end
