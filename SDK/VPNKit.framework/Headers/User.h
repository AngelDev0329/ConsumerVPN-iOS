//
//  User.h
//  VPNKit
//
//  Created by Kevin Hallmark on 1/14/16.
//  @copyright 2018 WLVPN All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Server;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Account Types

/**
 * A numeric representation of the current users account status.
 */
typedef NS_ENUM(NSInteger, VPNAccountStatus) {
	VPNAccountFree    = 0,
	VPNAccountTrial   = 1,
	VPNAccountPaid    = 2,
	VPNAccountExpired = 3
};

@interface User : NSManagedObject

/**
 * The users login username
 */
@property (nullable, nonatomic, retain) NSString *username;

/**
 * The users login password. Stored in the Keychain.
 */
@property (nullable, nonatomic, retain) NSString *password;

/**
 * The users account type (Free, Paid, Trial)
 */
@property (nullable, nonatomic, copy) NSNumber *accountType;

/**
 * The email address associated with the users account.
 */
@property (nullable, nonatomic, copy) NSString *email;

/**
 * The datetime that the users subscription ends
 */
@property (nullable, nonatomic, copy) NSDate *subscriptionEnd;

/**
 * The datetime that the users access tokens expire.
 */
@property (nullable, nonatomic, copy) NSDate *tokenExpiration;

/**
 * Auth username for VPN servers. Unique per user so that we don't expose credentials.
 */
@property (nullable, nonatomic, copy) NSString *authUser;

/**
 * Auth password for VPN servers. Unique per user so that we don't expose credentials.
 *
 * Retrieved from keychain.
 *
 * @todo Remove from keychain
 */
@property (nullable, nonatomic, retain) NSString *authPassword;

/**
 * Access token for the API.
 *
 * Retrieved from keychain.
 *
 * @todo Remove from keychain
 */
@property (nullable, nonatomic, retain) NSString *accessToken;

/**
 * Refresh token for the API.
 *
 * Retrieved from keychain.
 *
 * @todo Remove from keychain
 */
@property (nullable, nonatomic, retain) NSString *refreshToken;

/**
 * Do not use the keychain and set the properties directly.
 */
@property (nonatomic, assign) BOOL useKeychain;

/**
 * Returns the correct username for VPN auth
 *
 * @return The users authorization username for VPN
 */
- (NSString *)authUsername;

/**
 * Deprecated. Accessor returns username property. Here for compatibility.
 *
 * @return The users username
 */
- (NSString *)userID;

/**
 * Deprecated. Accessor returns the username property. Here for compatibility.
 *
 * @return The users username
 */
- (NSString *)accountID;

/**
 * Transforms the username for VPN Connection
 *
 * @param extension The username extension to use
 *
 * @return The transformed username string.
 */
- (NSString *)transformedUsername:(NSString *)extension;


- (NSData *)passwordData;


- (BOOL)isValidAccount;

/**
 * Checks to see if the user is expired.
 *
 * @return BOOL returns YES if the user is expired, returns NO otherwise.
 */
- (BOOL)isExpired;

@end

NS_ASSUME_NONNULL_END
