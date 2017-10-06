//
//  InvitedCell.h
//  Tracmojo
//
//  Created by macmini3 on 10/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitedCell : UITableViewCell
{
}
@property(strong,nonatomic) IBOutlet UIButton *btn_delete;
@property(strong,nonatomic) IBOutlet UIImageView *img_responde;
@property(strong,nonatomic) IBOutlet UILabel *lbl_name;
@property(strong,nonatomic) IBOutlet UILabel *lbl_resonsedtype;

@end
