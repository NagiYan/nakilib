//
//  NPictureSelectArrayView.m
//
//
//  Created by NAGI on 15/11/2.
//  Copyright © 2015年 NAGI. All rights reserved.
//

#import "NPictureSelectArrayView.h"
#import "UIActionSheet+Block.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"

@interface NPictureSelectArrayView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) NSMutableArray* imageViews;
@end

@implementation NPictureSelectArrayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [_imageViews release];
    [super dealloc];
}

- (void)setColumn:(NSInteger)column
{
    _column = column;
    [self p_updateUI];
}

- (void)setLimit:(NSInteger)limit
{
    _limit = limit;
    [self p_updateUI];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _column = 5;
        _limit = 5;
        _squareFix = YES;
        _imageSizeFix = 700;
        [self p_defaultUI];
    }

    return self;
}

- (NSArray*)images
{
    __block NSMutableArray* images = [[NSMutableArray new] autorelease];
    [_imageViews enumerateObjectsUsingBlock:^(UIButton*  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isAdd = [[[button imageView] image] isEqual:[UIImage imageNamed:@"add"]];
        if ([[button imageView] image] && !isAdd)
        {
            [images addObject:[[button imageView] image]];
        }
    }];
    return images;
}

#pragma mark - 
- (void)p_defaultUI
{
    _imageViews = [NSMutableArray new];
    [self p_addCell:0 image:[UIImage imageNamed:@"add"]];
}

- (void)p_updateUI
{
    while ([self subviews] && [[self subviews] count] > 0)
    {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    __block typeof(self) weakSelf = self;
    NSArray* images = [self images];
    
    [_imageViews release];
    _imageViews = [NSMutableArray new];
    
    __block UIView* lastView = nil;
    [images enumerateObjectsUsingBlock:^(UIImage*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        lastView = [weakSelf p_addCell:idx image:obj];
    }];
    
    if (_limit == 0 || [images count] < _limit)
    {
        lastView = [weakSelf p_addCell:[images count] image:[UIImage imageNamed:@"add"]];
        
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self superview]).with.offset(-10);
    }];

}

- (UIView*)p_addCell:(NSInteger)index image:(UIImage*)image
{
    NSInteger column = index%_column;
    float perWidth = ([UIScreen mainScreen].applicationFrame.size.width - 10*(_column+1))/_column;
    UIButton* button = [[UIButton new] autorelease];
    [self addSubview:button];
    [button setImage:image forState:UIControlStateNormal];
    if (![self squareFix]) {
        [[button imageView] setContentMode:UIViewContentModeScaleAspectFill];
    }

    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:3.0]; //设置矩圆角半径
    [button.layer setBorderWidth:1];   //边框宽度
    [button.layer setBorderColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0].CGColor];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10 + (perWidth + 10)*column);
        make.top.mas_equalTo(index/_column*(10 + perWidth) + 10);
        make.width.height.mas_equalTo(perWidth);
    }];
    
    [_imageViews addObject:button];
    
    BOOL isAdd = [image isEqual:[UIImage imageNamed:@"add"]];
    
    __block typeof(self) weakSelf = self;
    RACCommand* selectImg = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithCancelButtonTitle:@"取消"
                                                         destructiveButtonTitle:nil
                                                              otherButtonTitles:isAdd?@[@"拍照", @"相册"]:@[@"拍照", @"相册", @"删除"]];
        [sheet setTag:index];
        [sheet showInView:[weakSelf superview] usingBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 0:
                {
                    [weakSelf p_selectPicture:[actionSheet tag] source:UIImagePickerControllerSourceTypeCamera];
                    break;
                }
                case 1:
                {
                    [weakSelf p_selectPicture:[actionSheet tag] source:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                }
                case 2:
                {
                    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
                    [weakSelf p_updateUI];
                    break;
                }
                default:
                    break;
            }
            
        }];
        return [RACSignal empty];
    }];
    [button setRac_command:selectImg];
    return button;
}

// 选择图片
// 选择照相机
- (void) p_selectPicture:(NSInteger)index source:(UIImagePickerControllerSourceType)source
{
    //创建图片选择器
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    [imagePicker.view setTag:index];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:source])
    {
        //指定源的类型
        imagePicker.sourceType = source;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        if ([self squareFix]) {
            imagePicker.allowsEditing = YES;
        }
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        imagePicker.delegate = self;
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        [[self parentVC] presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 选择完成图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 压缩图片
    //CGSize photoSize0 = [[editingInfo objectForKey:UIImagePickerControllerOriginalImage] size];
    
    UIImage * imageThumb = nil;
    if ([self squareFix])
    {
        imageThumb = [self squareImageFromImage:image scaledToSize:[self imageSizeFix]];
    }
    else
    {
        CGSize photoSize = [image size];
        if (photoSize.height > [self imageSizeFix] || photoSize.width > [self imageSizeFix])
        {
            if (photoSize.height >= photoSize.width)
            {
                photoSize.width = photoSize.width/photoSize.height*[self imageSizeFix];
                photoSize.height = [self imageSizeFix];
            }
            else
            {
                photoSize.height = photoSize.height/photoSize.width*[self imageSizeFix];
                photoSize.width = [self imageSizeFix];
            }
        }
        imageThumb = [self thumbnailWithImage:image size:photoSize];
    }
    
    NSInteger index = [[picker view] tag];
    UIButton* button = _imageViews[index];
    [button setImage:imageThumb forState:UIControlStateNormal];
    [self p_updateUI];
}

#pragma mark - utils
/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize
{
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image)
    {
        newimage = nil;
    }
    else
    {
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newimage;
}
@end
