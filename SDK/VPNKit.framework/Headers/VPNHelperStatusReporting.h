//
//  VPNHelperStatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@protocol VPNStatusReporting;

@protocol VPNHelperStatusReporting <VPNStatusReporting>
@optional

/**
 * Notify the user that the Helper should be installed. Includes the current VPNConfiguration.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds `VPNConfiguration` type.
 */
- (void)statusHelperShouldInstall:(nonnull NSNotification *)notification;

/**
 * Notify the user that the Helper has been installed successfully.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds `VPNConfiguration` type.
 */
- (void)statusHelperDidInstall:(nonnull NSNotification *)notification;

/**
 * Notify the user that the Helper failed to install properly. Use this to set options back to defaults and inform the user of failure. Includes NSError describing issue.
 *
 * @param notification The notification kicked back from NotificationCenter. object property holds `NSError` type.
 */
- (void)statusHelperInstallFailed:(nonnull NSNotification *)notification;

@end
