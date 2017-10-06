//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface ABCIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property UIView *holeView;
@property UIView *circleView;
@property UIButton *doneButton;

@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    
    {
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = [UIImage imageNamed:@"bacground1"];
        [self addSubview:backgroundImageView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.82, self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        [self addSubview:self.pageControl];
      
      for(int i=0;i<4;i++)
      {
        [self createIntroScreen:i];
      }
   
    
       /* [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
        [self createViewFour];*/
       // [self createViewFive];
        
        
        //Done Button
        self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.90, self.frame.size.width*.8, 30)];
        [self.doneButton setTintColor:[UIColor whiteColor]];
        [self.doneButton setTitle:@"Skip" forState:UIControlStateNormal];
        [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]];
        self.doneButton.backgroundColor = [UIColor colorWithRed:39/255.0 green:151/255.0 blue:255/255.0 alpha:1.000];
       // self.doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
       // self.doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
        [self.doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
       // self.doneButton.layer.borderWidth =.5;
        self.doneButton.layer.cornerRadius = 15;
        [self addSubview:self.doneButton];
            
        
        self.pageControl.numberOfPages = 4;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}
-(void)createIntroScreen:(int)index
{
  
  CGFloat originWidth = self.frame.size.width;
  CGFloat originHeight = self.frame.size.height;
  
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*index,0, originWidth, originHeight)];
  
  
  
  UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, originWidth, originHeight)];
  imageview.contentMode = UIViewContentModeScaleAspectFit;
  
  if(index==0)
  {
    imageview.image = [UIImage imageNamed:@"intro1.png"];
  }
  else if (index==1)
  {
    imageview.image = [UIImage imageNamed:@"intro2.png"];
  }
  else if (index==2)
  {
    imageview.image = [UIImage imageNamed:@"intro3.png"];
  }
  else if (index==3)
  {
    imageview.image = [UIImage imageNamed:@"intro4.png"];
  }
  
 // [imageview setContentMode:UIViewContentModeCenter];
  [view addSubview:imageview];
  
  
  
 /* CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
  descriptionLabel.center = labelCenter;*/
  
  self.scrollView.delegate = self;
  [self.scrollView addSubview:view];
}

- (void)onFinishedIntroButtonPressed:(id)sender
{
    [self.delegate onDoneButtonPressed];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)onDoneButtonPressed
{
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
    
    if (pageFraction>3)
    {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            
            [self.delegate onDoneButtonPressed];
            
        }];
    }
    
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 120)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.2);
    titleLabel.text = [NSString stringWithFormat:@"SocialUp wants to make sharing what\n you want to do and with who...\n simple."];
    titleLabel.font = FONT_Bold(18);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"image1"];
//    
//    CGRect screenRect = imageview.frame;
//    
//    
//    //imageview.center
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((screenRect.size.width / 2),(screenRect.size.height / 2), 25, 25)];
//    
//    btn.center = imageview.center;
//   // btn.backgroundColor = [UIColor greenColor];
//    [btn setImage:[UIImage imageNamed:@"VideoPlay"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnPlayTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
   // [view addSubview:imageview];
   // [view addSubview:btn];
    
  
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)btnPlayTapped
{
    
    /*
     NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerWillExitFullscreenNotification as String!, object: nil)
     NSNotificationCenter.defaultCenter().addObserver(self, selector: "doneButtonClick:", name: MPMoviePlayerWillExitFullscreenNotification as String!, object: nil)
     */
    
    

    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playTapped) name:@"notify" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notify" object:nil userInfo:nil];
    
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"background"
//                                                         ofType:@"mov"];
//    
//    NSLog(@"%@",filePath);
//    MPMoviePlayerController *moviePlayerController = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:filePath]];
//
//    moviePlayerController.view.frame = self.window.frame;
//    
//    moviePlayerController.fullscreen = YES;
//    [moviePlayerController setControlStyle:MPMovieControlStyleNone];
//    moviePlayerController.shouldAutoplay = YES;
//    moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
//    moviePlayerController.repeatMode = MPMovieRepeatModeOne;
//    [moviePlayerController prepareToPlay];
//    [moviePlayerController play];
//    [self addSubview:moviePlayerController.view];
    
    
    
    
    
  //  self.navigationController.delegate = DELEGATE.transitionAnimator;
    
   // [self.navigationController pushViewController:obj_play_video animated:YES];

    
   
    
}

-(void)createViewTwo{
    
//    CGFloat originWidth = self.frame.size.width;
//    CGFloat originHeight = self.frame.size.height;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
//    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
//    titleLabel.text = [NSString stringWithFormat:@"What do you want to do?"];
//    titleLabel.font = FONT_Bold(18);
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment =  NSTextAlignmentCenter;
//    titleLabel.numberOfLines = 0;
//    [view addSubview:titleLabel];
//    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.14, self.frame.size.width*.8, self.frame.size.height/2.3)];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"intro1.png"];
//    [view addSubview:imageview];
//    
//    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
//    descriptionLabel.text = [NSString stringWithFormat:@"1. Enter status in text box.\n2. Not sure? Just tab green circle\nto let friends know you're free."];
//    descriptionLabel.font = FONT_Regular(18);
//    descriptionLabel.textColor = [UIColor blackColor];
//    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
//    descriptionLabel.numberOfLines = 0;
//    [descriptionLabel sizeToFit];
//    [view addSubview:descriptionLabel];
//    
//    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
//    descriptionLabel.center = labelCenter;
//    
//    self.scrollView.delegate = self;
//    [self.scrollView addSubview:view];
  
}

-(void)createViewThree{
    
//    CGFloat originWidth = self.frame.size.width;
//    CGFloat originHeight = self.frame.size.height;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
//    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
//    titleLabel.text = [NSString stringWithFormat:@"Now, with who?"];
//    titleLabel.font = FONT_Bold(18);
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment =  NSTextAlignmentCenter;
//    titleLabel.numberOfLines = 0;
//    [view addSubview:titleLabel];
//    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.14, self.frame.size.width*.8, self.frame.size.height/2.3)];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"intro2.png"];
//    [view addSubview:imageview];
////    imageview.contentMode = UIViewContentModeScaleAspectFit;
////    imageview.image = [UIImage imageNamed:@"Intro_Screen_Three"];
////    [view addSubview:imageview];
//    
//    
//    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
//    descriptionLabel.text = [NSString stringWithFormat:@"1. Using your preset groups, easily select \na whole group or individuals within.\n2. Only people selected will see your\n status."];
//    descriptionLabel.font = FONT_Regular(18);
//    descriptionLabel.textColor = [UIColor blackColor];
//    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
//    descriptionLabel.numberOfLines = 0;
//    [descriptionLabel sizeToFit];
//    [view addSubview:descriptionLabel];
//    
//    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
//    descriptionLabel.center = labelCenter;
//    
//    self.scrollView.delegate = self;
//    [self.scrollView addSubview:view];
  
}


-(void)createViewFour{
    
//    CGFloat originWidth = self.frame.size.width;
//    CGFloat originHeight = self.frame.size.height;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
//    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
//    titleLabel.text = [NSString stringWithFormat:@"See what your friends\n shared with you"];
//    titleLabel.font = FONT_Bold(18);
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment =  NSTextAlignmentCenter;
//    titleLabel.numberOfLines = 0;
//    [view addSubview:titleLabel];
//    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.15, self.frame.size.width*.8, self.frame.size.height/2.3)];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"intro3.png"];
//    [view addSubview:imageview];
////    imageview.contentMode = UIViewContentModeScaleAspectFit;
////    imageview.image = [UIImage imageNamed:@"Intro_Screen_Four"];
////    [view addSubview:imageview];
//    
//    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
//    descriptionLabel.text = [NSString stringWithFormat:@"1. View your groups to see what your\n friends are doing.\n2. Something look fun? Tap to join"];
//    descriptionLabel.font = FONT_Regular(18);
//    descriptionLabel.textColor = [UIColor blackColor];
//    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
//    descriptionLabel.numberOfLines = 0;
//    [descriptionLabel sizeToFit];
//    [view addSubview:descriptionLabel];
//    
//    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
//    descriptionLabel.center = labelCenter;
//    
//    self.scrollView.delegate = self;
//    [self.scrollView addSubview:view];
  
}

-(void)createViewFive{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*4, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"Five"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"image1"];
    [view addSubview:imageview];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"Intro_Screen_Two"];
//    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Description for Fourth Screen."];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}
@end