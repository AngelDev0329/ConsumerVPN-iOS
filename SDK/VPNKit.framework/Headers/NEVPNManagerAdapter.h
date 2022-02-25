/**
 * NEVPNManagerAdapter.h
 * VPNKit
 */

#import <Foundation/Foundation.h>

@protocol VPNConnectionAdapterProtocol;

#pragma mark - NEVPNManagerAdapter Connection Options

/**
 * Allows you to keep the profile on logout
 */
static NSString * const kKeepProfileOnLogout = @"KeepProfileOnLogout";

/**
 * Allows you to specify the level of encryption. Valid options are the constants kVPNEncryptionAES128 and kVPNEncryptionAES256
 */
static NSString * const kIKEv2Encryption                     = @"IKEv2Encryption";

/**
 * Allows you to specify the integrity algorithm
 */
static NSString * const kIKEv2IntegrityAlgorithm             = @"IKEv2IntegrityAlgorithm";

/**
 * Allows you to specify the authentication method
 */
static NSString * const kIKEv2AuthenticationMethod           = @"IKEv2AuthenticationMethod";

#pragma mark - NEVPNManagerAdapter On Demand Options

/**
 * Option to enable On Demand Rules. Option value is an NSNumber boolean
 */
static NSString * const kOnDemandEnabledKey                  = @"OnDemandEnabled";

/**
 * Option to disable On Demand for Cellular networks. Option value is an NSNumber boolean
 */
static NSString * const kOnDemandTrustCellularKey         = @"OnDemandCellularEnabled";

/**
 * Option to enable On Demand for Wi-Fi networks. Option value is an NSNumber boolean
 */
static NSString * const kOnDemandTrustWiFiKey              = @"OnDemandWiFiEnabled";

/**
 * Option to enable On Demand for Ethernet networks. Option value is an NSNumber boolean
 */
static NSString * const kOnDemandTrustEthernetKey              = @"OnDemandEthernetEnabled";

/**
 * Option to enable "Always On" On Demand Rule. Option value is an NSNumber boolean
 */
static NSString * const kOnDemandAlwaysOnKey                 = @"OnDemandAlwaysOn";

/**
 * Option to enable "Domain Based" On Demand Rules. Option value is an NSArray<NSString>
 */
static NSString * const kOnDemandDomainRulesKey              = @"OnDemandDomainRules";

/**
 * Option to enable SSID based whitelist. Option value is an NSArray<NSString>
 */
static NSString * const kOnDemandNetworkWhitelistRulesKey    = @"OnDemandNetworkWhitelistRules";

/**
 * Option to enable SSID based blacklist. Option value is an NSArray<NSString>
 */
static NSString * const kOnDemandNetworkBlacklistRulesKey    = @"OnDemandNetworkBlacklistRules";

#pragma mark - NEVPNManagerAdapter Advanced Options

static NSString * const kIKEv2UseIPAddress				     = @"IKEv2UseIPAddress";
static NSString * const kIKEv2DisableMobike					 = @"IKEv2DisableMobike";
static NSString * const kIKEv2RemoteIdentifier               = @"IKEv2RemoteIdentifier";
static NSString * const kIKEv2LifetimeValueKey               = @"IKEv2LifetimeValueKey";
static NSString * const kIKEv2ChildLifetimeValueKey          = @"IKEv2ChildLifetimeValueKey";

/**
 * Allows your application to connect to a VPN through the NEVPNManager interface provided by Apple.
 */
@interface NEVPNManagerAdapter : NSObject <VPNConnectionAdapterProtocol>

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

@end
