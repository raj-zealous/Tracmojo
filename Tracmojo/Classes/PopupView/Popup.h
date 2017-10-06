//
//  Popup.h
//  Tracmojo
//
//  Created by macmini3 on 06/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Popup : UIView <UITextFieldDelegate>
{
    ModelClass *mc;
    NSString *strInviteCode;
}
@property(strong,nonatomic)IBOutlet UIButton *btnpersonaltrac;
@property(strong,nonatomic)IBOutlet UIButton *btngrouptrac;
@property (weak, nonatomic) IBOutlet UIButton *btninfo;
@property (weak, nonatomic) IBOutlet UIButton *btngo;

@property (weak, nonatomic) IBOutlet UITextField *txtinvitecode;

@property (weak, nonatomic) IBOutlet UIView *alertView;

@property (weak, nonatomic) IBOutlet UITextView *alertTextView;

@property (weak, nonatomic) IBOutlet UIButton *btnOK;

@property (weak, nonatomic) IBOutlet UIView *okExitView;

@property (weak, nonatomic) IBOutlet UIView *okView;
@property (weak, nonatomic) IBOutlet UIView *hideShowView;

@property (weak, nonatomic) IBOutlet UIButton *btnOKSuccess;
@property (weak, nonatomic) IBOutlet UIButton *btnExitSuccess;


@end
