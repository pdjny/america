//
//  view.m
//  America
//
//  Created by PHILIP JACOBS on 7/6/13.
//  Copyright (c) 2013 PHILIP JACOBS. All rights reserved.
//

#import "view.h"

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;
	CGFloat stripeW = w / 13;
	CGFloat cantonW = w  * 7 / 13;
	CGFloat cantonH = h * 2 / 5;
	CGFloat cantonX = stripeW * 6;
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	//******************************************************************************
	//seven red stripes
	//******************************************************************************
	CGContextBeginPath(c);
	for (int i = 0; i <= 12; i+=2) {
		CGContextAddRect(c, CGRectMake((stripeW * i), 0, stripeW, h));
	}

	CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
	CGContextFillPath(c);
	
	//******************************************************************************
	//Blue Square
	//******************************************************************************
	CGContextBeginPath(c);
	//GContextAddRect(c, CGRectMake(0, 0, w/13, h));
	CGContextAddRect(c, CGRectMake(cantonX, 0, cantonW, cantonH));
	
	CGContextSetRGBFillColor(c, 0.0, 0.0, 1.0, 1.0);
	CGContextFillPath(c);
	//******************************************************************************
	// 50 White stars
	//******************************************************************************
	//White star has 5 vertices (points). (My experiment)
	CGFloat starD = stripeW * .8;
	CGFloat starR = starD / 2;
	
	CGContextBeginPath(c);

	//CGFloat theta = 0;		//Start with vertex pointing to right.
	//CGFloat x = center.x + radius * cosf(theta);
	//CGFloat y = center.y  - radius * sinf(theta);

	for (int j = 0; j <= 4; j+=1) {
		CGFloat starX = cantonX + (((j * 2) + 1) * (cantonW / 10));
		for (int k = 0; k <= 5; k+=1) {
			CGFloat starY = (((k * 2) + 1) * (cantonH / 12));
			CGPoint center = CGPointMake(starX, starY);
	
			for (int i = 0; i <= 10; i+=2) {
				CGFloat theta = 2 * M_PI * i / 5;
				CGFloat x = center.x + starR * cosf(theta);
				CGFloat y = center.y - starR * sinf(theta);
				if (i == 0) {
					CGContextMoveToPoint(c, x, y);
				} else {
					CGContextAddLineToPoint(c, x, y);
				}
			}
		}
	}
	
	for (int l = 0; l <= 3; l+=1) {
		CGFloat starX = cantonX + (((l + 1) * 2) * (cantonW / 10));
		for (int m = 0; m <= 4; m+=1) {
			CGFloat starY = (((m +1 ) * 2) * (cantonH / 12));
			CGPoint center = CGPointMake(starX, starY);
			
			for (int i = 0; i <= 10; i+=2) {
				CGFloat theta = 2 * M_PI * i / 5;
				CGFloat x = center.x + starR * cosf(theta);
				CGFloat y = center.y - starR * sinf(theta);
				if (i == 0) {
					CGContextMoveToPoint(c, x, y);
				} else {
					CGContextAddLineToPoint(c, x, y);
				}
			}
		}
	}

	//Works even though the star's outline intersects with itself.
	CGContextClosePath(c);
	CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
	CGContextFillPath(c);

	
	
	//The actor George C. Scott played General George S. Patton (1970).
	UIImage *image = [UIImage imageNamed: @"patton.jpg"];	//100 by 100
	if (image == nil) {
		NSLog(@"could not find the image");
		return;
	}
	
	//upper left corner of image
	CGPoint point = CGPointMake(
								(w - image.size.width) / 2,
								h - image.size.height - 20
								);
	
	[image drawAtPoint: point];
//	[self performSelector: @selector(setNeedsDisplay) withObject: nil afterDelay: .5];
}
@end
