//
//  KeyboardAutoViewController.m
//  west dean delicious
//
//  Created by westonnaki on 15/6/16.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "KeyboardAutoViewController.h"
#import "GScreen.h"

@interface KeyboardAutoViewController ()<UIGestureRecognizerDelegate>

@end

@implementation KeyboardAutoViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)] autorelease];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect frame = [[self view] frame];
    
    //if (keyboardSize.height > GScreenHeight - [self controlPosY])
    {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //[[self view] setFrame:CGRectMake(0, GScreenHeight - [self controlPosY] - keyboardSize.height, frame.size.width, frame.size.height)];
                             [[self view] setFrame:CGRectMake(0, 0, frame.size.width, GScreenHeight - keyboardSize.height)];
                             //[[self view] setFrame:CGRectMake(0, - keyboardSize.height, frame.size.width, GScreenHeight)];
                             [self keyboardShown:keyboardSize.height];
                         }
                         completion:nil];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect frame = [[self view] frame];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self view] setFrame:CGRectMake(0, 0, frame.size.width, GScreenHeight)];
                         [self keyboardHidden:keyboardSize.height];
                     }
                     completion:nil];
}

- (void)keyboardShown:(NSInteger)height
{
    
}

- (void)keyboardHidden:(NSInteger)height
{
    
}
@end
