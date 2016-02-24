//
//  UIUploadPictureView.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/26.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "UIUploadPictureView.h"
#import "ImageUtil.h"
#import "UIImageView+WebCache.h"
#import "UIViewUtil.h"
#import "ReactiveCocoa.h"
#import "UIActionSheet+Block.h"
#import "Masonry.h"
#import "ColorDefine.h"
#import "Chameleon.h"

@implementation UIUploadPictureView
{
    UIImageView* imageView;
    UIButton* btnAction;
}

- (void)dealloc
{
    [_url release];
    [_image release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)image;
{
    self = [super initWithFrame:frame];
    if (image)
        _image = [image retain];
    [self initDefault];
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        [_image release];
        _image = [image retain];
    }
}

- (id)initWithFrame:(CGRect)frame andImageUrl:(NSString*)url
{
    self = [super initWithFrame:frame];
    [self setUrl:url];
    [self initDefault];
    return self;
}


- (id)init
{
    self = [super init];
    [self initDefault];
    return self;
}

- (void)initDefault
{
    [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    
    [UIViewUtil freeSubViews:self];
    // 图
    imageView = [[UIImageView new] autorelease];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setClipsToBounds:YES];
    
    if ([self image])
    {
        [imageView setImage:[self image]];
    }
    else
    {
        if ([self url])
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[self url]]];
        }
        else
        {
            imageView.contentMode = UIViewContentModeCenter;
            [imageView setImage:[[UIImage imageNamed:@"add_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [imageView setTintColor:FlatWhite];
        }
    }
    
    // 背景
    btnAction = [[UIButton new] autorelease];
    [self addSubview:btnAction];
    [btnAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [btnAction setTitleColor:UICOLOR_TEXT_GREY forState:UIControlStateNormal];
    __block typeof(self) weakSelf = self;
    [[btnAction rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([[weakSelf delegate] respondsToSelector:@selector(didStartAction)]) {
            [[weakSelf delegate] didStartAction];
        }

        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传图片"
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@[@"拍照", @"从相册挑选"]];
        [actionSheet showInView:weakSelf usingBlock:^(UIActionSheet *sheet, NSInteger buttonIndex) {
            switch (buttonIndex)
            {
                case 0:
                    [weakSelf selectPicture:UIImagePickerControllerSourceTypeCamera];
                    break;
                case 1:
                    [weakSelf selectPicture:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                default:
                    break;
            }
        }];
    }];
    
    
    [self setFixPix:700];
    [self setSquareFix:YES];
}

#pragma mark - event
// 点击上传
- (void) selectPicture:(UIImagePickerControllerSourceType)source
{
    //创建图片选择器
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:source])
    {
        //指定源的类型
        imagePicker.sourceType = source;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        imagePicker.allowsEditing = YES;
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        imagePicker.delegate = self;
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        //[self presentModalViewController:imagePicker animated:YES];
        [[self parentController] presentViewController:imagePicker animated:YES completion:nil];
        [[[[self parentController] navigationController] navigationBar] setHidden:YES];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

// 选择完成图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 压缩图片
    //CGSize photoSize0 = [[editingInfo objectForKey:UIImagePickerControllerOriginalImage] size];
    
    UIImage * imageThumb = image;
    if ([self squareFix])
    {
        imageThumb = [ImageUtil squareImageFromImage:image scaledToSize:[self fixPix]];
    }
    else
    {
        CGSize photoSize = [image size];
        if (photoSize.height > [self fixPix] || photoSize.width > [self fixPix])
        {
            photoSize.height = [self fixPix];
            photoSize.width = [self fixPix];
            
            imageThumb = [ImageUtil thumbnailWithImage:image size:photoSize];
        }
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:imageThumb];
    [btnAction setTitle:@"" forState:UIControlStateNormal];
    
    [[self delegate] ImageChanged:imageThumb from:self];
    
    [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];
}

- (void)hideNav
{
    [[[[self parentController] navigationController] navigationBar] setAlpha:0];
    [[[[self parentController] navigationController] navigationBar] setHidden:NO];
}

@end
