/*
 * VPNPluginProtocol.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

#import <Foundation/Foundation.h>

@protocol VPNPluginProtocol <NSObject>

/**
 * Runs on logout from the API
 */
- (void)onLogout;

/**
 * Runs when the framework is cleaned up on terminate
 */
- (void)onCleanup;

/**
 * Runs after the helper successfully installs
 */
- (void)willConnect;

@end