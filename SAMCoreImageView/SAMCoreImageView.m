//
//  SAMCoreImageView.m
//  SAMCoreImageView
//
//  Created by Sam Soffes on 2/6/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

#import "SAMCoreImageView.h"

@interface SAMCoreImageView ()

@property (nonatomic) EAGLContext *glContext;
@property (nonatomic, readonly) CIContext *ciContext;

@end

@implementation SAMCoreImageView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self = [self initWithFrame:frame context:context];
    return self;
}


- (void)drawRect:(CGRect)rect {
    rect = CGRectMake(0.0, 0.0, self.drawableWidth, self.drawableHeight);
    [self.ciContext drawImage:self.image inRect:rect fromRect:self.image.extent];
}


#pragma mark - GLKView

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    NSParameterAssert(context);
    if ((self = [super initWithFrame:frame context:context])) {
        self.userInteractionEnabled = NO;
        self.opaque = NO;
        self.glContext = context;
    }
    return self;
}


#pragma mark - Accessors

@synthesize glContext = _glContext;
@synthesize ciContext = _ciContext;

- (CIContext *)ciContext {
    if (!_ciContext) {
        _ciContext = [CIContext contextWithEAGLContext:self.glContext options:[self contextOptions]];
    }
    return _ciContext;
}


- (void)setImage:(CIImage *)image {
    _image = image;
    if (self.enableSetNeedsDisplay) {
        [self setNeedsDisplay];
    }
    else {
        [self display];
    }
}


#pragma mark - Configuring

- (NSDictionary *)contextOptions {
    return @{
        kCIContextUseSoftwareRenderer: @NO
    };
}

@end
