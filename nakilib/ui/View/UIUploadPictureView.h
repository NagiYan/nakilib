//
//  UIUploadPictureView.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/26.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//  用来上传图片

#import <UIKit/UIKit.h>

@protocol UploadPictureViewDelegate <NSObject>

- (void)ImageChanged:(UIImage *)image from:(id)sender;
@optional
- (void)didStartAction;
@end

@interface UIUploadPictureView : UIView<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)image;
- (id)initWithFrame:(CGRect)frame andImageUrl:(NSString*)url;
- (id)initWithFrame:(CGRect)frame;
- (id)init;

@property (retain, nonatomic)UIImage*  image;
@property (retain, nonatomic)NSString* url;
@property (assign, nonatomic)UIViewController* parentController;
@property (assign, nonatomic)id<UploadPictureViewDelegate> delegate;
@property (assign, nonatomic)BOOL squareFix;
@property (assign, nonatomic)NSInteger fixPix;
@end
