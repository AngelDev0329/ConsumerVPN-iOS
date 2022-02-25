//
//  VPNConfigurationStatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@protocol VPNStatusReporting;

@protocol VPNConfigurationStatusReporting <VPNStatusReporting>
@optional

/**
 * Notify the receiver that the current `User` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentUserWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `User` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentUserDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Account` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentAccountWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Account` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentAccountDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Server` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentServerWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Server` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentServerDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `City` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentCityWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `City` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentCityDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Country` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentCountryWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current `Country` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentCountryDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current protocol of type `VPNProtocol` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentProtocolWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current protocol of type `VPNProtocol` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentProtocolDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current location of type `VPNCurrentLocationModel` of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentLocationWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current location of type `VPNCurrentLocationModel` of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusCurrentLocationDidChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current options of the VPNConfiguration is about to change
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusOptionsWillChange:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the current options of the VPNConfiguration has been changed
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds the newly updated `VPNConfiguration`
 */
- (void)statusOptionsDidChange:(nonnull NSNotification*)notification;

@end
