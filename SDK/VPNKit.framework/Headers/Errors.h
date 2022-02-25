//
//  Errors.h
//  VPNKit
//
//  Created by Kevin Hallmark on 6/27/17.
//  Copyright © 2017 WLVPN. All rights reserved.
//

@import Foundation;
//
//#ifndef Errors_h
//#define Errors_h

static NSString * VPNKitErrorDomain = @"VPNKitErrorDomain";

typedef NSInteger VPNKitError;

#pragma mark - Programmer Errors 1 - 99

typedef NS_ENUM(NSInteger, VPNFrameworkUsageError) {
	// A required configuration setting was not made.
	VPNKitConfigurationError = -1,

	// A parameter passed to the function was not valid. (Either nil or no length)
	VPNKitParameterError = 10,

	// VPN Setup Failed. Some component of the setup process didn't work. NEVPNManager, Helper Tool, etc...
	VPNKitVPNSetupError = 30,
};

#pragma mark - General Errors 900 - 999

typedef NS_ENUM(NSInteger, VPNImportError) {

	// Unknown Error
	VPNUnknownError = 900,

	// The provided API key is not valid
	VPNAPIKeyInvalidError = 901,
	// Request is missing a required parameter
	VPNAPIMissingRequiredParameterError = 902,
	// The user has attempted login too many times
	VPNAPITooManyFailedAttemptsError = 903,

	VPNDataImportError = 904,

	// VPNCoreDataMapper couldn't map the provided data
	VPNCoreDataMappingError = 905,

	// Connection Error
	VPNConnectionLostError = 940,

	// Connection Error
	VPNReachabilityError = 950,
};


#pragma mark - Login Errors 1000 - 1099

typedef NS_ENUM(NSInteger, VPNKitLoginError) {

	// Couldn't load the password from the keychain
	VPNLoginKeychainError = 1010,

	// Invalid credentials on login
	VPNLoginCredentialsError = 1020,

	// Access token is expired
	VPNAccessTokenExpiredError = 1021,

	// Refresh token is expired
	VPNRefreshTokenExpired = 1022,

	// Invalid credentials on login
	VPNLoginTooManyAttemptsError = 1023,

	// Invalid or Expired user account
	VPNLoginInvalidUserError = 1040,

	// China Error. Used if the resulting error is related to something with China.
	VPNKitChinaError = 1060,

	// The user has no internet
	VPNConnectionFailedNoInternet = 1070,
};

#pragma mark - Server Loading Errors 1100 - 1199

typedef NS_ENUM(NSInteger, VPNKitServerError) {
	// Unable to load servers
	VPNKitServerLoadError = 1121,
};

//#endif /* Errors_h */
