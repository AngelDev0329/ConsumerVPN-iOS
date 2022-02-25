//
// Created by Kevin Hallmark on 12/3/15.
// Copyright (c) 2016 WLVPN All rights reserved.
//

#import <Foundation/Foundation.h>

@class VPNCoreDataManager;
@class User;
@class VPNConfiguration;
@class VPNCurrentLocationModel;

#pragma mark - Callback Function Types

/**
 * Callback type used for login completion
 */
typedef void (^APILoginCompletionHandler)(User *, NSError *);

/**
 * Callback type used for server list update completion
 */
typedef void (^APIServerCompletionHandler)(NSArray *, NSError *);

/**
 * Callback type used when the current location changes
 */
typedef void (^APICurrentLocationUpdateHandler)(VPNCurrentLocationModel *, NSError *);

@protocol VPNAPIAdapterProtocol <NSObject>

#pragma mark - API Functions

/**
 * Logs the user in with the provided user (in the VPNConfiguration)
 *
 * @param vpnConfiguration  The VPNConfiguration to use for login
 * @param username          The username for login
 * @param password          The password for login
 * @param completionHandler The LoginCompletionHandler callback to run when login completes or errors out
 */
- (void)loginWithVPNConfiguration:(VPNConfiguration *)vpnConfiguration
						 username:(NSString *)username
						 password:(NSString *)password
			 andCompletionHandler:(APILoginCompletionHandler)completionHandler;

/**
 * Loads the initial server list for a given account/user. Loaded from data files that need to be provided in the options
 *
 * @param vpnConfiguration The VPNConfiguration to use during the initial server list load
 * @param completionHandler  A ServerCompletionHandler callback to run when the update is complete or errors out
 */
- (void)loadInitialServerListForVPNConfiguration:(VPNConfiguration *)vpnConfiguration
						   withCompletionHandler:(APIServerCompletionHandler)completionHandler;

/**
 * Updates the server list for a given account/user.
 *
 * @param vpnConfiguration The VPNConfiguration to use during the server list update
 * @param completionHandler  A ServerCompletionHandler callback to run when the update is complete or errors out
 */
- (void)updateServerListForVPNConfiguration:(VPNConfiguration *)vpnConfiguration
					  withCompletionHandler:(APIServerCompletionHandler)completionHandler;

/**
 * Execute the API call to refresh the current location.
 *
 * @param completionHandler Called when the current location has finished loading.
 */
- (void)refreshCurrentLocation:(APICurrentLocationUpdateHandler)completionHandler;

#pragma mark - Fetch Functions

/**
 * Fetch all of the cities in the API adapter
 *
 * @return An array of all cities
 */
- (NSArray *)fetchAllCities;

/**
 * Fetch all of the countries in the API adapter
 *
 * @return An array of all countries
 */
- (NSArray *)fetchAllCountries;

#pragma mark - Init Plugins

/**
 * Initialize any plugins that the API adapter might expose
 *
 * @return An dictionary of plugins. Always return a dictionary. If no plugins return empty dictionary.
 */
- (NSDictionary *)createPlugins;

#pragma mark - VPN Configuration Functions

/**
 * Initialize the VPN configuration object. Loads from data store and sets the vpn configuration
 *
 * @param defaultProtocol The default protocol to use
 */
- (VPNConfiguration *)initializeVPNConfiguration:(VPNProtocol)defaultProtocol;

/**
 * Refreshes the VPN configuration as needed (with core data this is used to refresh and fault check after server list
 * update)
 *
 * @param vpnConfiguration The VPN configuration to refresh
 */
- (void)refreshVPNConfiguration:(VPNConfiguration *)vpnConfiguration;

/**
 * Load balances the vpn configuration before connect or helper install.
 *
 * @param vpnConfiguration The configuration to load balance
 */
- (void)loadbalanceVPNConfiguration:(VPNConfiguration *)vpnConfiguration;

/**
 * Cleanup up private resources and log the user out
 */
- (void)logout;

@end
