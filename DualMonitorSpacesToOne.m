//
//  DualMonitorSpacesToOne.m
//  DualMonitorSpacesToOne
//
//  Created by soh kitahara on 09/04/12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DualMonitorSpacesToOne.h"

static NSInteger mainDisplay;
static NSString* dualMonitorPosition;
static BOOL enabled = NO;

@implementation NSWindow(DualMonitorSpacesToOne)

- (NSWindowCollectionBehavior)collectionBehavior {
	if([self checkAndSetSpace] == YES){
		return NSWindowCollectionBehaviorCanJoinAllSpaces;
	}else{
		return NSWindowCollectionBehaviorDefault;
	}
}

- (void) mouseDragged:(NSEvent *)theEvent {
	if( enabled == YES ){
		if([self checkAndSetSpace] == YES){
			[self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
		}else{
			[self setCollectionBehavior:NSWindowCollectionBehaviorDefault];
		}
	}
}

-(BOOL) checkAndSetSpace {
	if([dualMonitorPosition isEqual:@"subLeft"]){
		if( 0 > [self frame].origin.x + [self frame].size.width){
			return YES;
		}else{
			return NO;
		}
	}else if( [dualMonitorPosition isEqual:@"subRight"]){
		if( mainDisplay < [self frame].origin.x){
			return YES;
		}else{
			return NO;
		}
	}else if( [dualMonitorPosition isEqual:@"subUp"]){
		if( mainDisplay < [self frame].origin.y){
			return YES;
		}else{
			return NO;
		}
	}else if( [dualMonitorPosition isEqual:@"subDown"]){
		if( 0 > [self frame].origin.y + [self frame].size.height){
			return YES;
		}else{
			return NO;
		}	
	}
}
@end

@implementation DualMonitorSpacesToOne
+ (void) load {
	NSArray* array = [NSScreen screens];
	if([array count] > 1){
		enabled = YES;
		NSRect mainFrame = [[array objectAtIndex:0] frame];
		NSRect subFrame = [[array objectAtIndex:1] frame];
		if(mainFrame.size.width == subFrame.origin.x){
			mainDisplay = mainFrame.size.width;
			dualMonitorPosition = @"subRight";
		}else if( subFrame.origin.x == (-1)*subFrame.size.width){
			dualMonitorPosition = @"subLeft";
		}else if( subFrame.origin.y == (-1)*subFrame.size.height){
			dualMonitorPosition = @"subDown";
		}else if( mainFrame.size.height == subFrame.origin.y){
			dualMonitorPosition = @"subUp";
			mainDisplay = mainFrame.size.height;
		}
	}
	
	NSLog(@"DualMonitarSpacesToOne installed");
	
}
@end
