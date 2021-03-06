//
//  TracReview.h
//  Tracmojo
//
//  Created by macmini3 on 14/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"

@interface tracrate : UIViewController
{
    ModelClass *mc;
        IBOutlet UIScrollView *scroll_popup;
    IBOutlet UIButton *btnmain;
    IBOutlet UIButton *btn_color1;
    IBOutlet UIButton *btn_color2;
    IBOutlet UIButton *btn_color3;
    IBOutlet UIButton *btn_color4;
    IBOutlet UIButton *btn_color5;
    IBOutlet UIButton *btnCheckbox,*btnCheckbox2;

    __weak IBOutlet NSLayoutConstraint *imageViewRateTopConstant;
    
    __weak IBOutlet NSLayoutConstraint *imageviewRateBotomCOnstaint;
    
    IBOutlet UILabel *lbl_text1;
    IBOutlet UILabel *lbl_text2;
    IBOutlet UILabel *lbl_text3;
    IBOutlet UILabel *lbl_text4;
    IBOutlet UILabel *lbl_text5;
    IBOutlet UIImageView *imgerate,*previewImage;
    
    IBOutlet UILabel *lbl_gole;
    IBOutlet UILabel *lbl_frequency;
    IBOutlet UILabel *lbl_detail;
    
    IBOutlet UIView *obj_view_comment;
    IBOutlet UIButton *btn_cancel,*btncoment;
    IBOutlet UIButton *btn_Message;
    IBOutlet UITextField *txt_message;
    
    __weak IBOutlet UIButton *btn_BusinessName;
    
    
    IBOutlet UITextView *txtbox;
    BOOL isPopUP;
}
@property(strong,nonatomic)NSDictionary *dic_rate;
@property (strong, nonatomic) IBOutlet UILabel *lableComment;

-(IBAction)btnChek:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblPopTrackRatePopUP;

- (IBAction)btnBusinessNameClicked:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *trackRateHeaderElement;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblGoletopConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblDetailTopConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblGoleHightCOnst;

-(IBAction)btnChek2:(id)sender;
-(IBAction)comment:(id)sender;

@end
