/*
 * VPNCurrentLocationModel.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

#import <Foundation/Foundation.h>

/**
 * Represents the users current location as determined by our location API (via IP address)
 */
@interface VPNCurrentLocationModel : NSObject

/**
 * The name of the geolocated city
 */
@property NSString *city;

/**
 * The name of the geolocated country
 */
@property NSString *country;

/**
 * The name of the geolocated region ("state" in the United States)
 */
@property NSString *region;

/**
 * The users ip address
 */
@property NSString *ipAddress;

/**
 * The approximate latitude of the user (used for load balancing)
 */
@property NSNumber *latitude;

/**
 * The approximate longitude of the user (used for load balancing)
 */
@property NSNumber *longitude;


/**
 * Returns a user readable location string for convenience.
 *
 * @return A string like Orlando, FL, United States
 */
- (NSString *)location;

@end
