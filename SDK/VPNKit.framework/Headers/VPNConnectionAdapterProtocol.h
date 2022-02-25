/**
 * VPNConnectionAdapterProtocol.h
 * VPNKit
 */
#import <Foundation/Foundation.h>

@class Server;

#pragma mark - Callback Function Types

typedef void (^VPNHelperInstallCompletionHandler)(BOOL);

typedef void (^VPNIntialSetupCompletionHandler)(void);

/**
 * Called when the connection status changes
 */
typedef void (^VPNStatusHandler)(VPNConnectionStatus, NSError *);

/**
 * Called when the configuration of the adapter has changed due to an external process.
 * Mainly used when the NEVPNManager changes, but could be used by other adapters.
 */
typedef void (^VPNExternalConfigurationChangedHandler)(NSError *);

/**
 * This protocol defines the way the VPNAPIManager interacts with the Connection Adapters. Functions in the adapter
 * should be included in this order. Class specific functions at the bottom of the file.
 */
@protocol VPNConnectionAdapterProtocol <NSObject>

#pragma mark - Properties

/**
 * Stores when the VPN is connected. NSDate if connected, nil if disconnected.
 */
@property (nonatomic, copy) NSDate *connectedDate;

/**
 * Allows the Adapter to report connection status and changes to VPNAPIManager.
 */
@property (nonatomic, copy) VPNStatusHandler statusHandler;

/**
 * Allows the Adapter to report external configuration changes
 */
@property (nonatomic, copy) VPNExternalConfigurationChangedHandler configurationChangedHandler;

#pragma mark - Init

/**
 * A ConnectionAdapter must be allowed to receive options from the owning application.
 *
 * @param options A bunch of options
 *
 * @return self
 */
- (id)initWithOptions:(NSDictionary *)options;

#pragma mark - Setup Initial State

/**
 * Allows a connection adapter to configure its initial state.
 */
- (void)setupInitialStateWithVPNConfiguration:(VPNConfiguration *)vpnConfiguration
						 andCompletionHandler:(VPNIntialSetupCompletionHandler)completionHandler;

#pragma mark - Supported Protocols

/**
 * Returns a BOOL YES if the protocol is supported by this handler, NO if it's not.
 *
 * @param vpnProtocol The VPNProtocol to check support
 *
 * @return BOOL
 */
- (BOOL)supportsProtocol:(VPNProtocol)vpnProtocol;

/**
 * Returns an array of supported protocols to the caller
 *
 * @return Array of supported protocols for this adapter
 */
- (NSArray *)supportedProtocols;

#pragma mark - Helper Install Functions

/**
 * Executed when an adapter becomes active
 */
- (void)activateAdapter:(VPNConfiguration *)vpnConfiguration;

/**
 * Executed when an adapter becomes inactive
 */
- (void)deactivateAdapter:(VPNConfiguration *)vpnConfiguration;

/**
 * This function drives helper installation. It can, synchronously or asynchronously, determine if the helper
 * is installed. Once your adapter determines if the helper is installed, it should call the completion handler.
 * This function is used by multiple methods in the VPNAPIManager. Each function that calls it may provide a different
 * completion handler.
 *
 * @param vpnConfiguration The VPNConfiguration to check for helper install
 * @param completionHandler VPNAPIManager
 */
- (void)isHelperInstalledForVPNConfiguration:(VPNConfiguration *)vpnConfiguration
					   withCompletionHandler:(VPNHelperInstallCompletionHandler)completionHandler;

/**
 * Install the helper for the VPNConfiguration provided. This function can assume that
 * isHelperInstalledForVPNConfiguration has been called on the adapter prior to invocation.
 *
 * @param vpnConfiguration The VPNConfiguration to install
 * @param completionHandler A completion handler for VPNAPIManager
 */
- (void)installHelperForVPNConfiguration:(VPNConfiguration *)vpnConfiguration
				   withCompletionHandler:(VPNHelperInstallCompletionHandler)completionHandler;

/**
 * Remove the VPN Configuration from the user's VPN Preferences.
 *
 * @param completionHandler A completion handler for VPNAPIManager
 */
- (void)removeHelperWithCompletionHandler:(VPNHelperInstallCompletionHandler)completionHandler;

#pragma mark - Connection Functions

/**
 * Connects to the VPN server with the provided VPNConfiguration.
 *
 * @param vpnConfiguration The VPNConfiguration to connect to.
 */
- (void)connectWithVPNConfiguration:(VPNConfiguration *)vpnConfiguration;

/**
 * Disconnect from the VPN server
 */
- (void)disconnect;

/**
 * Cleans up the connection when the user disconnects manually.
 */
- (void)cleanUpAfterDisconnectWithVPNConfiguration:(VPNConfiguration *)vpnConfiguration
								   isUserInitiated:(BOOL)userInitiated;

/**
 * Does this adapter support "stay connected on quit"?
 *
 * @return YES if it does and NO if it does not.
 */
- (BOOL)supportsStayConnectedOnQuit;

#pragma mark - Kill Switch Functions

/**
 * Does the current adapter support the "Kill Switch" feature?
 *
 * @return YES if it's supported, NO if it is not supported
 */
- (BOOL)supportsKillSwitch;

/**
 * Is the Kill Switch currently enabled?
 *
 * @return YES if it is currently enabled, NO if it is not currently enabled
 */
- (BOOL)isKillSwitchEnabled;

/**
 * Is the kill switch currently engaged?
 *
 * @return YES if it is current engage and NO if it is not currently engaged
 */
- (BOOL)isKillSwitchEngaged;

/**
 * Turn on the "Kill Switch" (do not allow network traffic)
 */
- (void)engageKillSwitch;

/**
 * Turn off the "Kill Switch" (allow network traffic)
 */
- (void)disengageKillSwitch;

@end
