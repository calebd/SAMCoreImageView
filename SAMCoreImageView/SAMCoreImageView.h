//
//  SAMCoreImageView.h
//  SAMCoreImageView
//
//  Created by Sam Soffes on 2/6/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

@import GLKit;
@import CoreImage;

@interface SAMCoreImageView : GLKView

@property (nonatomic, strong) CIImage *image;

- (NSDictionary *)contextOptions;

@end
