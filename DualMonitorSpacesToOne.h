//
//  DualMonitorSpacesToOne.h
//  DualMonitorSpacesToOne
//
//  Created by soh kitahara on 09/04/12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface NSWindow (DualMonitorSpacesToOne) 
-(BOOL) checkAndSetSpace;
@end

@interface DualMonitorSpacesToOne : NSObject {

}
+ (void) load;
@end
