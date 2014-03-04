//
//  SAMCoreImageView.m
//  SAMCoreImageView
//
//  Created by Sam Soffes on 2/6/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

#import "SAMCoreImageView.h"

@import GLKit;
@import CoreImage;

@interface SAMCoreImageView ()

@property (nonatomic, readonly) GLKView *glView;
@property (nonatomic, readonly) EAGLContext *glContext;
@property (nonatomic, readonly) CIContext *ciContext;

@end

@implementation SAMCoreImageView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = NO;
        [self addSubview:self.glView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.glView.frame = self.bounds;
}


#pragma mark - Accessors

@synthesize glContext = _glContext;
@synthesize glView = _glView;
@synthesize ciContext = _ciContext;

- (EAGLContext *)glContext {
    if (!_glContext) {
        _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _glContext;
}


- (GLKView *)glView {
    if (!_glView) {
        _glView = [[GLKView alloc] initWithFrame:CGRectZero context:self.glContext];
        _glView.delegate = self;
        _glView.opaque = NO;
    }
    return _glView;
}


- (CIContext *)ciContext {
    if (!_ciContext) {
        _ciContext = [CIContext contextWithEAGLContext:self.glContext options:[self contextOptions]];
    }
    return _ciContext;
}


- (void)setImage:(CIImage *)image {
    _image = image;
    [self.glView setNeedsDisplay];
}


#pragma mark - Configuring

- (NSDictionary *)contextOptions {
	return @{
		kCIContextUseSoftwareRenderer: @NO
	};
}


#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    rect = CGRectMake(0.0, 0.0, view.drawableWidth, view.drawableHeight);
    [self.ciContext drawImage:self.image inRect:rect fromRect:self.image.extent];
}

@end
