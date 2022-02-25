//
//  VPNServerStatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@protocol VPNStatusReporting;

@protocol VPNServerStatusReporting <VPNStatusReporting>
@optional
#pragma mark Server Capacity Notifications
/**
 * Notify the receiver that the currently connected server's capacity is greater than 80% maximum capacity.
 */
- (void)statusServerCapacityWarning;

#pragma mark Server Update Notifications
/**
 * Notify the receiver that the first ServerUpdateWillBegin notification has been thrown since starting the application.
 */
- (void)statusInitialServerUpdateWillBegin;

/**
 * Notify the receiver that the first ServerUpdateSucceeded notification has been thrown since starting the application.
 *  Includes Array of Servers.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds Array of type `Server`
 */
- (void)statusInitialServerUpdateSucceeded:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the first ServerUpdateFailed notification has been thrown since starting the application.
 *  Includes NSError describing the reason for failure.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds type `NSError`
 */
- (void)statusInitialServerUpdateFailed:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the list of servers are about to update.
 */
- (void)statusServerUpdateWillBegin;

/**
 * Notify the receiver that the list of servers were updated successfully. Includes Array of Servers that were updated.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds Array of type `Server`
 */
- (void)statusServerUpdateSucceeded:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the list of servers failed to update. Includes an NSError describing the reason for failure.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds type `NSError`
 */
- (void)statusServerUpdateFailed:(nonnull NSNotification*)notification;

#pragma mark Ping City Notifications
/**
 * TODO: Description needs to be filled
 */
- (void)statusPingForCityDidComplete;

/**
 * Notify the receiver that a City has finished getting Ping information from each of its servers and sets the average to the city.
 *
 * @param notification The notification kicked back from NotificationCenter. userInfo property holds name of city in key `city` as a String
 */
- (void)statusPingDataCache:(nonnull NSNotification*)notification;

@end
