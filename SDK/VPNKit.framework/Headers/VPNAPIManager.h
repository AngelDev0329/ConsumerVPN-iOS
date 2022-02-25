//
// Created by Kevin Hallmark on 12/3/15.
// Copyright (c) 2016 WLVPN All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VPNPluginProtocol;
@protocol VPNAPIAdapterProtocol;
@protocol VPNConnectionAdapterProtocol;

static NSString * _Nonnull kBundleNameKey                  = @"BundleName";
static NSString * _Nonnull kBrandNameKey                   = @"BrandName";
static NSString * _Nonnull kCoreDataURLKey                 = @"CoreDataURL";
static NSString * _Nonnull kPingCacheURLKey                = @"PingCacheURL";
static NSString * _Nonnull kVPNServerReloadIntervalKey     = @"VPNServerReloadInterval";
static NSString * _Nonnull kVPNDefaultProtocolKey          = @"VPNDefaultProtocol";
static NSString * _Nonnull kVPNServiceNameKey              = @"VPNServiceName";
static NSString * _Nonnull kVPNAccessGroupNameKey          = @"VPNAccessGroupName";
static NSString * _Nonnull kVPNOldServiceNameKey           = @"VPNOldServiceName";
static NSString * _Nonnull kSetCityAndCountryOnInitialLoad = @"SetCityAndCountryOnInitialLoad";
static NSString * _Nonnull kCityPOPHostname                = @"CityPOPHostname";

/**
 * The VPNAPIManager is the central object responsible for the SDK. It does the job of coordination between the API
 * adapter, the connection adapters and the client application.
 */
@interface VPNAPIManager : NSObject

#pragma mark - Properties

/**
 * The VPNConfiguration manages the selection of Country/City/Server and stores properties for use by the application.
 */
@property (readonly) VPNConfiguration * _Nonnull vpnConfiguration;

/**
 * The current connection status. Better to use designated accessors like `isConnectedToVPN`
 */
@property (assign) VPNConnectionStatus status;

/**
 * Is the internet currently reachable by the device?
 */
@property (assign) BOOL networkIsReachable;

#pragma mark - Designated Initializer

/**
 * Initializes the APIManager with the provided APIAdapter and the provided ConnectionAdapters. Both of these objects
 * must subscribe to their respective protocol. Also allows you to pass in customization options to be used by the
 * manager.
 *
 * @param apiAdapter         The APIAdapter to use for this APIManager
 * @param connectionAdapters An array of connection adapters to use for this APIManager.
 * @param options            Developer provided optional parameters
 */
- (instancetype _Nullable)initWithAPIAdapter:(NSObject<VPNAPIAdapterProtocol> * _Nonnull)apiAdapter
						  connectionAdapters:(NSArray * _Nonnull)connectionAdapters
								  andOptions:(NSDictionary * _Nonnull)options;

/**
 * Initializes the APIManager with the provided APIAdapter and the provided ConnectionAdapter. Both of these objects
 * must subscribe to their respective protocol. Also allows you to pass in customization options to be used by the
 * manager.
 *
 * @param apiAdapter        The APIAdapter to use for this APIManager
 * @param connectionAdapter The ConnectionAdapter to use for this APIManager.
 * @param options           Developer provided optional parameters
 */
- (instancetype _Nullable)initWithAPIAdapter:(NSObject<VPNAPIAdapterProtocol> * _Nonnull)apiAdapter
	   connectionAdapter:(NSObject<VPNConnectionAdapterProtocol> * _Nonnull)connectionAdapter
			  andOptions:(NSDictionary * _Nonnull)options;

/**
 * Returns the path to the main VPNKit log file
 *
 * @return The path of the log file
 */
- (NSString * _Nullable)logFile;

/**
 * Cleanup the VPNAPIManager before application termination.
 */
- (void)cleanup;

@end

@interface VPNAPIManager (APIHandling)

#pragma mark User Session Management

/**
 * This function will login to the current adapter with the provided username and password.
 *
 * When the function starts, it will immediately send a VPNLoginWillBeginNotification.
 * If any error occurs, this function will post a VPNLoginFailedNotification with the object set to an NSError.
 * If login succeeds, this function will post a VPNLoginSucceededNotification with the object set to the new Account.
 *
 * @param username The username of of the user to login
 * @param password The password of the user to login
 */
- (void)loginWithUsername:(NSString * _Nonnull)username password:(NSString * _Nonnull)password;

/**
 * Logs the current user out and removes all their information from Core Data
 */
- (void)logout;

/**
 * Determines if a user is currently logged-in so you can show the correct UI
 *
 * @return YES if the user is logged in, NO if the user is not logged in
 */
- (BOOL)isLoggedIn;

#pragma mark - Refresh Location Functions

/**
 * Refreshes the users current location using the API adapter
 */
- (void)refreshLocation;

#pragma mark - Update Server List

/**
 * Updates the server list and saves it to the current list of servers.
 */
- (void)updateServerList;

#pragma mark - Fetch Country Functions

/**
 * Fetches all countries
 *
 * @return An array of all countries
 */
- (NSArray * _Nonnull)fetchAllCountries;

#pragma mark - Fetch City Functions

/**
 * Fetches all cities
 *
 * @return An array of all cities
 */
- (NSArray * _Nonnull)fetchAllCities;

@end

@interface VPNAPIManager (ConnectionHandling)

#pragma mark - Connection Functions

/**
 * Connect to the VPN with the provided VPNConfiguration
 */
- (void)connect;

/**
 * Disconnect from the currently connected server. Calls [self disconnect:YES]
 */
- (void)disconnect;

/**
 * Disconnect from the VPN. We have the flag because a system initiated disconnect should behave differently from a user
 * initiated disconnect.
 *
 * Example: the NEVPNManager needs to turn off "on-demand" on a user initiated disconnect.
 *
 * @param isUserInitiated Did the user or the system generate this disconnect event
 */
- (void)disconnect:(BOOL)isUserInitiated;

/**
 * Checks to see if currently connected to the VPN.
 *
 * @return Returns YES if connected. Returns NO otherwise.
 */
- (BOOL)isConnectedToVPN;

/**
 * Checks to see if currently connecting to the VPN.
 *
 * @return Returns YES if connecting. Returns NO otherwise.
 */
- (BOOL)isConnectingToVPN;

/**
 * Checks to see if currently disconnecting from the VPN.
 *
 * @return Returns YES if disconnecting. Returns NO otherwise.
 */
- (BOOL)isDisconnectingFromVPN;

/**
 * Checks to see if currently disconnected from the VPN.
 *
 * @return Returns YES if disconnected. Returns NO otherwise.
 */
- (BOOL)isDisconnectedFromVPN;

#pragma mark - Connection Timer Functions

/**
 * An NSDate that contains the date/time that the VPN was connected
 *
 * @return The NSDate the user connected at
 */
- (NSDate * _Nullable)connectedDate;

/**
 * The connected time in seconds
 *
 * @return An integer number of seconds or -1 if not connected
 */
- (NSTimeInterval)connectedTimeInSeconds;

#pragma mark - Helper Install Functions

/**
 * Checks whether the helper is currently installed. This function may be asynchronous. If the helper is not installed,
 * this function will fire VPNHelperShouldInstallNotification.
 */
- (void)isHelperInstalled;

/**
 * Installs the helper for the current VPNConfiguration. This function may be asynchronous. If the helper is installed,
 * this function will fire VPNHelperDidInstallNotification. If it fails, it will fire VPNHelperInstallFailedNotification.
 *
 * @param connect Connect to the VPN if the helper installs successfully.
 */
- (void)installHelperAndConnectOnInstall:(BOOL)connect;

@end

@interface VPNAPIManager (ProtocolHelpers)

/**
 * Return an array of supported protocols from ALL connection adapters
 *
 * @return Array of supported protocols
 */
- (NSArray * _Nonnull)supportedProtocols;

/**
 * Returns the appropriate VPNProtocol for a provided string value.
 *
 * @param protocolString The protocolString value
 *
 * @return The VPNProtocol integer that corresponds to the protocolString
 */
- (VPNProtocol)protocolForString:(NSString * _Nonnull)protocolString;

@end

@interface VPNAPIManager (PluginHandling)

/**
 * Adds a plugin to the VPNAPIManager
 *
 * @param plugin The plugin protocol conforming object
 * @param key    The plugin key
 */
- (void)addPlugin:(id<VPNPluginProtocol>_Nullable)plugin forKey:(NSString *_Nullable)key;

/**
 * Gets a plugin from the VPNAPIManager
 *
 * @param key The plugin key
 *
 * @return The plugin object
 */
- (id <VPNPluginProtocol>_Nullable)getPlugin:(NSString *_Nullable)key;

@end
