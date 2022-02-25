//
//  NSString+IPValidation.h
//  IPVanish
//
//  Created by Kevin Hallmark on 10/14/15.
//  Copyright © 2015 Mudhook Marketing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IPValidation)

- (BOOL)isValidIPAddress;
- (BOOL)isValidIP4Address;
- (BOOL)isValidIP6Address;

@end
