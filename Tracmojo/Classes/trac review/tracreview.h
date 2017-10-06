//
//  tracreview.h
//  Tracmojo
//
//  Created by macmini3 on 15/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"
#import "CommentsViewController.h"
#import "FHSTwitterEngine.h"
#import <MessageUI/MessageUI.h>

@class SLComposeViewController;


@interface tracreview : UIViewController<FHSTwitterEngineAccessTokenDelegate,MFMailComposeViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDelegate>
{
    ModelClass *mc;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIScrollView *scroll_popup;
    IBOutlet UIView *sub_view;
     SLComposeViewController *slComposerSheet;
    
    IBOutlet UILabel *lbl_tractype,*lblnext,*lbltractodate;
    
        IBOutlet UILabel *lbl_dates;
        IBOutlet UILabel *lbl_type;
    
    IBOutlet UIButton *btn_comment;
    
    
    IBOutlet UIView *view_gole_p;
    IBOutlet UILabel *lbl_gole_p;
    
      IBOutlet UIImageView *imgLine,*badgeimag,*previewImage;
    
    IBOutlet UIView *view_gole_g;
    IBOutlet UILabel *lbl_gole_g;
    IBOutlet UILabel *lbl_detail_g;
    
    
    IBOutlet UILabel *lblViewAddcomments;
    IBOutlet UILabel *lbl_finish_date,*lbl_sharethis;
    IBOutlet UILabel *lbl_start_date;
    IBOutlet UILabel *lbl_group_followers;
    IBOutlet UILabel *lbl_participated;
    IBOutlet UILabel *lbl_owner;
    IBOutlet UILabel *lbl_trac_to_date;
    IBOutlet UILabel *lbl_next;
    IBOutlet UILabel *lbl_communicate;
    IBOutlet UIButton *btn_notification;
    IBOutlet UIButton *btn_email;
    IBOutlet UIButton *btn_facebook;
    IBOutlet UIButton *btn_twitter;
    IBOutlet UIButton *btn_send_mail;
    
    IBOutlet UILabel *lbl_msg,*lbl_badge;
    IBOutlet UIView *obj_view_comment;
    IBOutlet UIButton *btn_cancel;
    IBOutlet UIButton *btn_Message,*btnmcal;
    IBOutlet UITextField *txt_message;
    
    IBOutlet UIView *graph_view;
    IBOutlet UIImageView *i8;
    
    __weak IBOutlet UIButton *btnBusinessName;
    
     IBOutlet UIButton *addF,*addP;
    
    tracreview *track;
    
    BOOL isdetailcall;
    
}
//@property (nonatomic, strong) id <ARlinePinch> alertdelegate;
@property(nonatomic,retain) IBOutlet UITextField *textview;

@property(strong,nonatomic) UIDatePicker *datePicker1;
@property(strong,nonatomic)NSString *trac_id;
@property(strong,nonatomic)NSDictionary *trac_detail_dic;
@property(strong,nonatomic)NSDictionary *trac_offline_dic;

-(IBAction)btncal:(id)sender;
-(IBAction)info:(id)sender;

-(IBAction)btncalmessage:(id)sender;

- (IBAction)urlClicked:(UIButton *)sender;


-(IBAction)Addf:(id)sender;
-(IBAction)Addp:(id)sender;
@property (strong, nonatomic) NSMutableDictionary *postParams;
@end

