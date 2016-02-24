//
//  BigImageViewController.m
//  HealthManagement
//
//  Created by Martin on 14-4-13.
//  Copyright (c) 2014年 BST. All rights reserved.
//

#import "BigImageViewController.h"

@interface BigImageViewController ()

@end

@implementation BigImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (nil != self.showImage) {
        [self.bigImageView setImage:self.showImage];
    }
    self.bigImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *uitgr = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(dimiss)] autorelease];
    uitgr.numberOfTapsRequired = 1;
    [self.bigImageView addGestureRecognizer:uitgr];
}

- (void)dimiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bigImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBigImageView:nil];
    [super viewDidUnload];
}
@end
