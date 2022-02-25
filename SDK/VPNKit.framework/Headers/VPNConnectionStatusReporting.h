//
//  VPNConnectionStatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@protocol VPNStatusReporting;

@protocol VPNConnectionStatusReporting <VPNStatusReporting>
@optional

/**
 * Notify the receiver that the connection logic is about to take place. Use this time to prep for the connection.
 */
- (void)statusConnectionWillBegin;

/**
 * Notify the receiver that the connection logic has started. This will result in a success or a failure. Use this time to inform the user of progress.
 */
- (void)statusConnectionDidBegin;

/**
 * Notify the receiver that the connection logic will reconnect.
 */
- (void)statusConnectionWillReconnect;

/**
 * Notify the receiver that the connection logic has completed successfully. Use this to inform the user of great success.
 */
- (void)statusConnectionSucceeded;

/**
 * Notify the receiver that the connection logic has completed with a failure. Use this to inform the user of what went wrong. Includes an NSError describing the issue.
 *
 * @param notification The notification kicked back from the NotificationCenter. object property holds `NSError` type.
 */
- (void)statusConnectionFailed:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the disconnection logic is about to take place. Use this time to prep for the disconnection and to inform the user of progress.
 */
- (void)statusConnectionWillDisconnect;

/**
 * Notify the receiver that the disconnection logic has completed. Use this to inform the user the disconnection has finished.
 */
- (void)statusConnectionDidDisconnect;

/**
 * Notify the receiver that the connection is currently in an active state.
 */
- (void)statusConnectionActive;

/**
 * Notify the receiver about incoming and outgoing network data used. Includes a bandwidth object with this information.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds type `VPNBandwidthModel`
 */
- (void)statusNetworkMonitorUpdate:(nonnull NSNotification*)notification;

@end
