//
//  Notifications.h
//  VPNKit
//
//  Created by Kevin Hallmark on 8/2/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#ifndef Notifications_h
#define Notifications_h

#pragma mark - VPNConfiguration Property Change Notifications

static NSString * const VPNCurrentUserWillChangeNotification = @"VPNCurrentUserWillChangeNotification";
static NSString * const VPNCurrentUserDidChangeNotification  = @"VPNCurrentUserDidChangeNotification";

static NSString * const VPNCurrentAccountWillChangeNotification = @"VPNCurrentAccountWillChangeNotification";
static NSString * const VPNCurrentAccountDidChangeNotification  = @"VPNCurrentAccountDidChangeNotification";

static NSString * const VPNCurrentServerWillChangeNotification = @"VPNCurrentServerWillChangeNotification";
static NSString * const VPNCurrentServerDidChangeNotification  = @"VPNCurrentServerDidChangeNotification";

static NSString * const VPNCurrentCityWillChangeNotification = @"VPNCurrentCityWillChangeNotification";
static NSString * const VPNCurrentCityDidChangeNotification  = @"VPNCurrentCityDidChangeNotification";

static NSString * const VPNCurrentCountryWillChangeNotification = @"VPNCurrentCountryWillChangeNotification";
static NSString * const VPNCurrentCountryDidChangeNotification  = @"VPNCurrentCountryDidChangeNotification";

static NSString * const VPNCurrentProtocolWillChangeNotification = @"VPNCurrentProtocolWillChangeNotification";
static NSString * const VPNCurrentProtocolDidChangeNotification  = @"VPNCurrentProtocolDidChangeNotification";

static NSString * const VPNCurrentLocationWillChangeNotification = @"VPNCurrentLocationWillChangeNotification";
static NSString * const VPNCurrentLocationDidChangeNotification  = @"VPNCurrentLocationDidChangeNotification";

static NSString * const VPNOptionsWillChangeNotification = @"VPNOptionsWillChangeNotification";
static NSString * const VPNOptionsDidChangeNotification  = @"VPNOptionsDidChangeNotification";

#pragma mark - Login/Logout Notifications

static NSString * const VPNLoginWillBeginNotification = @"VPNLoginWillBeginNotification";
static NSString * const VPNLoginSucceededNotification = @"VPNLoginSucceededNotification";
static NSString * const VPNLoginFailedNotification    = @"VPNLoginFailedNotification";

static NSString * const VPNAutomaticLoginSucceededNotification = @"VPNAutomaticLoginSucceededNotification";

static NSString * const VPNLogoutWillBeginNotification = @"VPNLogoutWillBeginNotification";
static NSString * const VPNLogoutSucceededNotification = @"VPNLogoutSucceededNotification";
static NSString * const VPNLogoutFailedNotification    = @"VPNLogoutFailedNotification";

#pragma mark - Server Update Notifications
static NSString * const VPNInitialServerUpdateWillBeginNotification = @"VPNInitialServerUpdateWillBeginNotification";
static NSString * const VPNInitialServerUpdateSucceededNotification = @"VPNInitialServerUpdateSucceededNotification";
static NSString * const VPNInitialServerUpdateFailedNotification    = @"VPNInitialServerUpdateFailedNotification";

static NSString * const VPNServerUpdateWillBeginNotification = @"VPNServerUpdateWillBeginNotification";
static NSString * const VPNServerUpdateSucceededNotification = @"VPNServerUpdateSucceededNotification";
static NSString * const VPNServerUpdateFailedNotification    = @"VPNServerUpdateFailedNotification";

#pragma mark - Server Capacity Notifications

static NSString * const VPNServerCapacityWarning = @"VPNServerCapacityWarningNotification";

#pragma mark - Ping/Speed Test Notifications

static NSString * const VPNNetworkMonitorUpdateNotification = @"VPNNetworkMonitorUpdateNotification";

static NSString * const VPNPingDataCachePingNotification      = @"VPNPingDataCachePingNotification";
static NSString * const VPNPingForCityDidCompleteNotification = @"VPNPingForCityDidCompleteNotification";

static NSString * const VPNSpeedTestWillBeginNotification = @"VPNSpeedTestWillBeginNotification";
static NSString * const VPNSpeedTestDidBeginNotification  = @"VPNSpeedTestDidBeginNotification";
static NSString * const VPNSpeedTestUpdateNotification    = @"VPNSpeedTestUpdateNotification";
static NSString * const VPNSpeedTestCompleteNotification  = @"VPNSpeedTestCompleteNotification";
static NSString * const VPNSpeedTestFailedNotification    = @"VPNSpeedTestFailedNotification";

#pragma mark - Helper Notifications

static NSString * const VPNHelperShouldInstallNotification = @"VPNHelperShouldInstallNotification";
static NSString * const VPNHelperDidInstallNotification    = @"VPNHelperDidInstallNotification";
static NSString * const VPNHelperInstallFailedNotification = @"VPNHelperInstallFailedNotification";

#pragma mark - Connection Notifications

static NSString * const VPNConnectionWillBeginNotification      = @"VPNConnectionWillBeginNotification";
static NSString * const VPNConnectionDidBeginNotification       = @"VPNConnectionDidBeginNotification";
static NSString * const VPNConnectionWillReconnectNotification  = @"VPNConnectionWillReconnectNotification";
static NSString * const VPNConnectionSucceededNotification      = @"VPNConnectionSucceededNotification";
static NSString * const VPNConnectionFailedNotification         = @"VPNConnectionFailedNotification";
static NSString * const VPNConnectionWillDisconnectNotification = @"VPNConnectionWillDisconnectNotification";
static NSString * const VPNConnectionDidDisconnectNotification  = @"VPNConnectionDidDisconnectNotification";
static NSString * const VPNConnectionActiveNotification         = @"VPNConnectionActiveNotification";

#endif /* Notifications_h */
