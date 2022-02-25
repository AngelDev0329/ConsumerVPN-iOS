//
//  Enums.h
//  VPNKit
//
//  Created by Kevin Hallmark on 3/8/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@import Foundation;

#ifndef Enums_h
#define Enums_h

#pragma mark - VPNProtocol

/**
 * A numeric representation of the VPNProtocol. Used by the VPNConfiguration and VPNAPIManager in the selectedProtocol
 * property.
 */
typedef NS_ENUM(NSInteger, VPNProtocol) {
	VPNProtocolInvalid   = 0,
	VPNProtocolL2TP      = 1,
	VPNProtocolPPTP      = 2,
	VPNProtocolIPSec     = 3,
	VPNProtocolIKEv2     = 4,
	VPNProtocolOpenVPN_UDP   = 5,
	VPNProtocolOpenVPN_TCP   = 6,
};

#pragma mark - VPNProtocol Display Strings

/**
 * String constant for invalid protocol
 */
static NSString * kVPNProtocolInvalid     = @"Invalid";

/**
 * String constant for L2TP protocol
 */
static NSString * kVPNProtocolL2TP        = @"L2TP";

/**
 * String constant for PPTP protocol
 */
static NSString * kVPNProtocolPPTP        = @"PPTP";

/**
 * String constant for IPSec protocol
 */
static NSString * kVPNProtocolIPSec       = @"IPSec";

/**
 * String constant for IKEv2 protocol
 */
static NSString * kVPNProtocolIKEv2       = @"IKEv2";

/**
 * String constant for openvpn udp
 */
static NSString * kVPNProtocolOpenVPN_UDP = @"OpenVPN UDP";

/**
 * String constant for openvpn tcp
 */
static NSString * kVPNProtocolOpenVPN_TCP = @"OpenVPN TCP";

#pragma mark - VPNEncryption Constants

/**
 * An numeric repersentation of the various supported encryption levels.
 */
typedef NS_ENUM(NSInteger, VPNEncryption) {
	VPNEncryptionNone   = 0,
	VPNEncryptionAES128 = 1,
	VPNEncryptionAES256 = 2,
};

/**
 * A string constant for no encryption
 */
static NSString * kVPNEncryptionNone = @"No encryption";

/**
 * A string constant for AES-128 encryption
 */
static NSString * kVPNEncryptionAES128 = @"AES-128";

/**
 * A string constant for AES-256 encryption
 */
static NSString * kVPNEncryptionAES256 = @"AES-256";

#pragma mark - VPNConnectionStatus

/**
 * The current connection status as an integer.
 */
typedef NS_ENUM(NSInteger, VPNConnectionStatus) {
	VPNStatusDisconnected  = 0,
	VPNStatusConnecting    = 1,
	VPNStatusConnected     = 2,
	VPNStatusReconnecting  = 3,
	VPNStatusDisconnecting = 4,
	VPNStatusInvalid       = 5,
	VPNStatusActive        = 6,
	VPNStatusFailed        = 7,
	VPNStatusError         = 8,
	VPNStatusReconnect     = 9,
};

#pragma mark - Connection Adapter Option Keys

static NSString * const kVPNApplicationSupportDirectoryKey = @"VPNApplicationSupportDirectoryKey";
static NSString * const kVPNManagerUsernameExtensionKey = @"VPNManagerConnectionUsernameExtension";
static NSString * const kVPNManagerBrandNameKey         = @"VPNManagerBrandNameKey";
static NSString * const kVPNManagerMobileProfileKey     = @"VPNManagerMobileProfileKey";
static NSString * const kVPNManagerServiceNameKey       = @"VPNManagerServiceNameKey";
static NSString * const kVPNSharedSecretKey             = @"VPNSharedSecret";

#endif /* Enums_h */
