//
//  ABELTableViewIndex.m
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//


#import "ALDTableViewIndex.h"

#if !__has_feature(objc_arc)
#error AIMTableViewIndexBar must be built with ARC.
// You can turn on ARC for only AIMTableViewIndexBar files by adding -fobjc-arc to the build phase for each of its files.
#endif


@interface ALDTableViewIndex (){
    BOOL isLayedOut;
    CAShapeLayer *shapeLayer;
    CGFloat letterHeight;
    
    
    CATextLayer *oldlayer;
    UIImageView *backlayer;
    
    
}

@property (nonatomic, strong) NSArray *letters;

@end


@implementation ALDTableViewIndex

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setup{
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineCapSquare;
    shapeLayer.strokeColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeEnd = 1.0f;
    self.layer.masksToBounds = NO;
}
- (void)addMagnifyView
{
    if (_magnifyView) {
        [_magnifyView removeFromSuperview];
        _magnifyView = nil;
    }
    
    _magnifyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, letterHeight)];
    [_magnifyView setContentMode:UIViewContentModeScaleAspectFit];
    UIImage *image_touming = [UIImage imageNamed:@"magnifyImage"];
    [_magnifyView setImage:image_touming];
    
    [self addSubview:_magnifyView];
//    [self bringSubviewToFront:_magnifyView];
    
}
- (void)setTableViewIndexDelegate:(id<ALDTableViewIndexDelegate>)tableViewIndexDelegate
{
    _tableViewIndexDelegate = tableViewIndexDelegate;
    self.letters = [self.tableViewIndexDelegate tableViewIndexTitle:self];
    isLayedOut = NO;
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setup];
    
    if (!isLayedOut){
        
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        shapeLayer.frame = (CGRect) {.origin = CGPointZero, .size = self.layer.frame.size};
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        letterHeight = 16; //self.frame.size.height / [letters count];
        CGFloat fontSize = 12;
        if (letterHeight < 14){
            fontSize = 11;
        }
        
        //选择索引背景色
        backlayer = [[UIImageView alloc] init];
        
        backlayer.frame = CGRectMake((self.frame.size.width-14)/2, 20, 14, 14);
        backlayer.alpha = 0.8;
        
        if(_bageColor){
            backlayer.backgroundColor = _bageColor;
        }else{
//            backlayer.backgroundColor = [UIColor colorWithRed:99.0/255 green:196.0/255 blue:93.0/255 alpha:0.8];
            backlayer.backgroundColor = K_COLOR_LIGHTGREEN;
            
        }
        //        backlayer.backgroundColor = [UIColor purpleColor];
        
        backlayer.hidden = YES;
        [backlayer.layer setMasksToBounds:YES];
        [backlayer.layer setCornerRadius:7];
        [self addSubview:backlayer];
        //放大镜
        
        if (!_isHiddenHeaderImage) {
            [self addMagnifyView];

        }
        
        [self.letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * letterHeight + 20;
            CATextLayer *tl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, letterHeight)];
            [self.layer addSublayer:tl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(tl.frame.size.width, originY)];
        }];
        
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        
        isLayedOut = YES;
    }
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    
    if (_textColor) {
        [tl setForegroundColor:_textColor.CGColor];
    }else{
        [tl setForegroundColor:K_COLOR_LIGHTBLACK.CGColor];
    }

    [tl setString:string];
    return tl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    int index =  [self sendEventToDelegate:event];
    
    if (index == 0) {
        [self.tableViewIndexDelegate tableViewIndexTouchesBegan:self];
    }else{
        backlayer.hidden = YES;
        
        if (oldlayer) {
            
            if (oldlayer.position.y<0) {
                //button
            }else{
                
                [oldlayer setForegroundColor:_textColor?_textColor.CGColor:K_COLOR_LIGHTBLACK.CGColor];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    int index =  [self sendEventToDelegate:event];
    
    if (index == -1) {
        [self.tableViewIndexDelegate tableViewIndexTouchesBegan:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tableViewIndexDelegate tableViewIndexTouchesEnd:self];
}
- (void)searchAction
{
    if (self.tableViewIndexDelegate && [self.tableViewIndexDelegate respondsToSelector:@selector(searchButtonTouched)]) {
        [self.tableViewIndexDelegate searchButtonTouched];
    }
}

- (int)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    int indx = (int) (point.y / letterHeight) -1;
    
    if (indx< 0 || indx > self.letters.count - 1) {
        
        if (indx == -1 ) {
            //触摸了放大镜
            if (!_isHiddenHeaderImage) {
                [self searchAction];
            }
        }
        return -1;
    }
    
    [self.tableViewIndexDelegate tableViewIndex:self didSelectSectionAtIndex:indx withTitle:self.letters[indx]];
    
    
    
    //-//-//
    
    backlayer.hidden = NO;
    CGFloat originY = indx * letterHeight;
    
    backlayer.frame = CGRectMake((self.frame.size.width-14)/2, originY+20, 14, 14);
    
    
    if (oldlayer) {
        
        if (oldlayer.position.y<0) {
            //button
        }else{
     
            [oldlayer setForegroundColor:_textColor?_textColor.CGColor:K_COLOR_LIGHTBLACK.CGColor];
        }
    }
    [(CATextLayer *)[self.layer.sublayers objectAtIndex:indx+2] setForegroundColor:RGB(255, 255, 255, 1).CGColor];
    
    oldlayer = (CATextLayer *)[self.layer.sublayers objectAtIndex:indx+2];
    
    return 0;

}

#pragma mark - 自定义样式
- (void)setBageColor:(UIColor *)bageColor
{
    backlayer.backgroundColor = bageColor;
    
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CATextLayer class]]) {
            [(CATextLayer*)layer setForegroundColor:textColor.CGColor];

        }
    }
}
-(void)setIsHiddenHeaderImage:(BOOL)isHiddenHeaderImage
{
    _isHiddenHeaderImage = isHiddenHeaderImage;
    
    _magnifyView.hidden = YES;
    
}
-(void)setHeaderImage:(UIImage *)headerImage
{
    _headerImage = headerImage;
    [_magnifyView setImage:headerImage];
}
@end
