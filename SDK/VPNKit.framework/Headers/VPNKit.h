//
//  VPNKit.h
//  VPNKit
//
//  Created by Kevin Hallmark on 12/3/15.
//  @copyright 2018 WLVPN All rights reserved.
//


#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC && !TARGET_OS_IPHONE
#import <Cocoa/Cocoa.h>
#endif

#ifndef VPNKitHeader_h
#define VPNKitHeader_h

#import <VPNKit/Errors.h>
#import <VPNKit/Constants.h>

#pragma mark - Notification Related Extensions

#import <VPNKit/Notifications.h>
#import "NSNotificationCenter+StatusReporting.h"
#import <VPNKit/VPNStatusReporting.h>
#import <VPNKit/VPNAccountStatusReporting.h>
#import <VPNKit/VPNConfigurationStatusReporting.h>
#import <VPNKit/VPNConnectionStatusReporting.h>
#import <VPNKit/VPNHelperStatusReporting.h>
#import <VPNKit/VPNServerStatusReporting.h>

#pragma mark - Model Includes

#import <VPNKit/User.h>
#import <VPNKit/Server.h>
#import <VPNKit/Country.h>
#import <VPNKit/ServerProtocol.h>
#import <VPNKit/ProtocolType.h>
#import <VPNKit/City.h>

#pragma mark - Common Includes

#import <VPNKit/VPNConfiguration.h>
#import <VPNKit/VPNAPIManager.h>

#pragma mark - Current Location Manager Includes

#import <VPNKit/VPNCurrentLocationModel.h>
#import <VPNKit/VPNBandwidthModel.h>

#pragma mark - Adapter Protocol Includes

#import <VPNKit/VPNPluginProtocol.h>
#import <VPNKit/VPNAPIAdapterProtocol.h>
#import <VPNKit/VPNConnectionAdapterProtocol.h>
#import <VPNKit/VPNConfigurationDelegate.h>

#pragma mark - Default Adapter Includes

#import <VPNKit/NEVPNManagerAdapter.h>
#import <VPNKit/VPNConnectionTestAdapter.h>

#pragma mark - IPValidation Category

#import <VPNKit/NSString+IPValidation.h>

// CocoaLumberjack is embedded in the framework to provide robust logging to both
// TTY and File
#pragma mark - CocoaLumberjack

#define DD_LEGACY_MACROS 0

// Core
#import <VPNKit/DDLog.h>

// Main macros
#import <VPNKit/DDLogMacros.h>
#import <VPNKit/DDAssertMacros.h>

// Loggers
#import <VPNKit/DDFileLogger.h>
#import <VPNKit/DDTTYLogger.h>

// Ignore this header file. Moving out of SDK.
#import <VPNKit/Analytics.h>

@protocol NameProtocol

@property (nullable, nonatomic, retain) NSString *name;

@end

#endif


