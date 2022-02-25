/*
 * VPNConfiguration.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

#import <Foundation/Foundation.h>

@class VPNCurrentLocationModel;
@class VPNPingDataCache;
@class VPNCoreDataManager;

@protocol VPNConfigurationDelegate;

#pragma mark - VPNConfiguration Options

/**
 * If the currently connected adapter supports, "supportsStayConnectedOnQuit", then the VPN connection will remain
 * active on quit. Value is an NSNumber boolean
 */
static NSString * const kStayConnectedOnQuit = @"StayConnectedOnQuit";

/**
 * This class manages the state of the VPN configuration and API state for the app. You can set/get the current user,
 * account, country, city, server, etc.... you can also set VPN connection options such as on-demand.
 */
@interface VPNConfiguration : NSObject

/**
 * Initialize the VPNConfiguration with the provided options.
 *
 * @param options Allows you to mass set options on instantiation
 *
 * @return Returns an instantiated VPN Configuration with the provided options
 */
- (id)initWithOptions:(NSDictionary *)options andDelegate:(id<VPNConfigurationDelegate>)delegate;

/**
 * Used to temporarily disable notifications while the VPNConfiguration is created.
 */
@property BOOL enableNotifications;

/**
 * Determines if this VPN configuration has been changed and needs to be reinstalled. Set to YES when a property is changed
 * and set to NO when the installHelper is called.
 */
@property BOOL dirty;

/**
 * An object that represents the current *login credentials*. Login will create a User and assign one or more accounts.
 */
@property (strong, nonatomic) User *user;

/**
 * The Actual Server the User will or is connected to. Should be set on connect.
 */
@property (strong, nonatomic) Server *server;

/**
 * The city for which a connection should be attempted, or that the user is currently connected to.
 */
@property (strong, nonatomic) City *city;

/**
 * The country for which a connection should be attempted, or that the user is currently connected to.
 */
@property (strong, nonatomic) Country *country;

/**
 * The current location model for the current vpnConfiguration.
 */
@property VPNCurrentLocationModel *currentLocation;

/**
 * The currently selected protocol
 */
@property VPNProtocol selectedProtocol;

/**
 * Returns the string representation of the currently selected protocol
 */
- (NSString *)getSelectedProtocolName;

/**
 * The default protocol
 */
@property VPNProtocol defaultProtocol;

/**
 * Should this object automatically save keys in to NSUserDefaults?
 */
@property BOOL syncToUserDefaults;

/**
 * Stores whether or not the VPN Configuration is using
 */
@property BOOL usingAutoselectedCountry;

/**
 * Stores whether or not the VPN Configuration is using
 */
@property BOOL usingAutoselectedCity;

/**
 * Stores whether or not the VPN Configuration is using
 */
@property BOOL usingAutoselectedServer;

/**
 * Sets the country, then the city, using a city object;
 *
 * @param city The city to set into the VPNConfiguration
 */
- (void)setCityAndCountry:(City *)city;

/**
 * Returns a value from the options dictionary for the specified key.
 *
 * @param key The specified key to perform a lookup with.
 *
 * @return id the value for the specified key. Returns nil if not found.
 */
- (id)getOptionForKey:(NSString *)key;

/**
 * Sets an option in the vpn options dictionary and updates any KVO observers
 * for this property change.
 *
 * @param option The new value to be updated in the options dictionary.
 * @param key The key for the option in the options dictionary.
 */
- (void)setOption:(id)option forKey:(NSString *)key;

/**
 * Returns whether or not the requested option is set.
 *
 * @return BOOL Yes if has the option set, No if it does not.
 */
- (BOOL)hasOptionForKey:(NSString *)key;

/**
 * Verify that the current configuration is a valid and connectable configuration
 *
 * @param error Message containing the error
 * @return YES if successful, NO if not
 */
- (BOOL)isValidConfigurationWithError:(NSError **)error;

/**
 * Clears the autoselected servers if applicable. You should not need to call this method directly.
 */
- (void)clearAutoselected;

/**
 * Destroys the objects in the VPNConfiguration and removes them from user defaults (used for logout).
 */
- (void)destroy;

@end
