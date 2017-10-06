//
//  Dashboard.h
//  Tracmojo
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"
#import "SKSTableView.h"
#import <sqlite3.h>
#import "SWTableViewCell.h"




@interface Dashboard : UIViewController <SWTableViewCellDelegate , UITextFieldDelegate>

{
    IBOutlet UISegmentedControl *segment_trac;
    IBOutlet UIScrollView *scrollview;
    ModelClass *mc,*mc1;
    int start_personal,start_group,start_follow;
    
}
@property(strong,nonatomic)IBOutlet UIView *objview;
@property(strong,nonatomic)IBOutlet UIButton *btn_personaltrac;
@property(strong,nonatomic)IBOutlet UIButton *btn_grouptrac;
@property(nonatomic,readwrite)int isFromPopup;


@property (strong, nonatomic)NSString *strID;
@property (strong, nonatomic)NSString *str_callinvitation;
@property (nonatomic, weak) IBOutlet SKSTableView *tableView;
@property(strong,nonatomic)    NSDictionary *dic_personltrac;
@property(strong,nonatomic)    NSDictionary *dic_grouptrac;
@property(strong,nonatomic)    NSDictionary *dic_followtrac;
@property(strong,nonatomic)    NSMutableDictionary *dic_maintrac;
@property(strong,nonatomic)    NSMutableArray *array_ratecolor;
@property(strong,nonatomic)    NSMutableArray *array_personal;
@property(strong,nonatomic)    NSMutableArray *array_group;
@property(strong,nonatomic)    NSMutableArray *array_followed;
@property(strong,nonatomic)    NSMutableArray *array_section;

-(IBAction)loadmore:(id)sender;
- (IBAction)btnLogoutClicked:(id)sender;

@end
