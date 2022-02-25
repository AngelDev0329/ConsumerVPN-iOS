/*
 * VPNConfigurationDelegate.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

#import <Foundation/Foundation.h>

static NSString * const kVPNUser     = @"VPNUser";
static NSString * const kVPNCountry  = @"VPNCountry";
static NSString * const kVPNCity     = @"VPNCity";
static NSString * const kVPNServer   = @"VPNServer";
static NSString * const kVPNProtocol = @"VPNProtocol";
static NSString * const kVPNOptions  = @"VPNOptions";

@protocol VPNConfigurationDelegate

- (void)syncDefault:(id)object forKey:(NSString *)key;

- (void)removeDefaultForKey:(NSString *)key;

@end