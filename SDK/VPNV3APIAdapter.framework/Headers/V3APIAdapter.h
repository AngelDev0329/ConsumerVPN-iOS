/*
 * IPVAPIAdapter.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

@import Foundation;
@import CoreData;
@import VPNKit;

@protocol VPNAPIAdapterProtocol;

/**
 * 1000 - Password is a required field
 * 1001 - API Key Invalid
 * 1001 - Bearer token invalid
 * 1001 - Request has no Bearer token in header
 * 1009 - Could not provision OAuth
 * 1100 - The username associated with this token could not be found
 * 1100 - The username or password provided is incorrect
 * 1101 - Refresh token invalid
 * 1102 - Refresh token expired
 * 1105 - Bearer token expired
 */

/**
 * ENUM of all the errors that can come back from the API
 */
typedef NS_ENUM(NSInteger, APIError) {
	// Missing a required POST parameter (probably password)
	APIErrorMissingRequiredParameter   = 1000,
	// The API Key provided is invalid
	APIErrorInvalidApiKey              = 1001,
	// The bearer token is invalid or not provided
	APIErrorNoBearerTokenKey           = 1001,
	APIErrorInvalidBearerTokenKey      = 1001,
	// Too many failed login attempts to the api
	APIErrorTooManyFailedLoginAttempts = 1099,
	// Invalid Username or Password on Login
	APIErrorInvalidUserNameOrPassword  = 1100,
	// Expired Refresh Token
	APIErrorRefreshTokenInvalid        = 1101,
	APIErrorRefreshTokenExpired        = 1102,
	// Expired Access Token
	APIErrorAccessTokenExpired         = 1105
};

static NSString * const kV3CoreDataURL         = @"V3CoreDataURL";
static NSString * const kV3ClientNameKey       = @"V3ClientName";
static NSString * const kV3OSNameKey           = @"V3OSName";
static NSString * const kV3BaseUrlKey          = @"V3BaseUrl";
static NSString * const kV3LocationURLKey      = @"V3LocationURL";
static NSString * const kV3ApiKey 		       = @"V3ApiKey";
static NSString * const kV3InitialServersKey   = @"V3InitialServers";
static NSString * const kV3InitialProtocolsKey = @"V3InitialProtocols";
static NSString * const kV3UUIDKey 		       = @"V3UUID";

@interface V3APIAdapter : NSObject <VPNAPIAdapterProtocol>

/**
 * The default NSManagedObjectContext to use for this adapter. Private contexts will be created from this one.
 */
@property (nonatomic, retain) NSManagedObjectContext *defaultContext;

/**
 * Initialize the IPV3APIAdapter with the provided options
 *
 * @param options A dictionary of options to assign to this adapter instance
 *
 * @return A fully instantiated IPV3APIAdapter ready to make API calls
 */
- (id)initWithOptions:(NSDictionary *)options;
    
    
- (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context withBlock:(void (^)(void))block error:(NSError **)error;
- (void)executeLoginCallback:(APILoginCompletionHandler)completionHandler withUser:(User *)user andError:(NSError *)error;

@end
