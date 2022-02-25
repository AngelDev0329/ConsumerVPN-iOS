//
//  VPNAccountStatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@protocol VPNStatusReporting;

@protocol VPNAccountStatusReporting <VPNStatusReporting>
@optional
/**
 * Notify receiver that the login operation is about to begin.
 */
- (void)statusLoginWillBegin;

/**
 * Notify the receiver that the login operation has completed successfully. Includes the Account information.
 *
 * @param notification The notification kicked back from the NotificationCenter. object property holds `Account` type.
 */
- (void)statusLoginSucceeded:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that the login operation has completed with a failure. Includes an NSError describing the issue.
 *
 * @param notification The notification kicked back from the NotificationCenter. object property holds `NSError` type
 */
- (void)statusLoginFailed:(nonnull NSNotification*)notification;

/**
 * Notify the receiver that an automatic login operation did occur
 *
 * @param notification The notification kicked back from the NotificationCenter. object property holds `NSError` type
 */
- (void)statusAutomaticLoginSuceeded:(nonnull NSNotification *)notification;

/**
 * Notify the receiver that the logout operation is about to begin.
 */
- (void)statusLogoutWillBegin;

/**
 * Notify the receiver that the logout operation has completed successfully.
 */
- (void)statusLogoutSucceeded;

/**
 * Notify the receiver that the logout operation has completed with a failure. Includes an NSError describing the issue.
 *
 * @param notification The notification kicked back from the NotificationCenter. object property holds `NSError` type.
 */
- (void)statusLogoutFailed:(nonnull NSNotification*)notification;;

@end
