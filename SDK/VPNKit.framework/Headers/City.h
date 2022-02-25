//
//  City.h
//  VPNKit
//
//  Created by Kevin Hallmark on 1/4/16.
//  @copyright 2018 WLVPN All rights reserved.
//

@import Foundation;
@import CoreData;

@class Country, Server;

NS_ASSUME_NONNULL_BEGIN

/**
 * Represents a physical location that contains servers.
 */
@interface City : NSManagedObject

/**
 * A unique identifier for the city. Composed of cityName:countryCode.
 *
 * Example: Atlanta:US
 */
@property (nullable, nonatomic, copy) NSString *cityID;

/**
 * The name of the city.
 *
 * Example: Atlanta
 */
@property (nullable, nonatomic, copy) NSString *name;

/**
 * A three letter code used to identify the POP.
 *
 * Example: atl
 */
@property (nullable, nonatomic, copy) NSString *popName;

/**
 * The latitude of the city
 */
@property (nullable, nonatomic, copy) NSNumber *latitude;

/**
 * The longitude of the city
 */
@property (nullable, nonatomic, copy) NSNumber *longitude;

/**
 * The country this city is in.
 */
@property (nullable, nonatomic, retain) Country *country;

/**
 * A set of servers that are in this City.
 */
@property (nullable, nonatomic, retain) NSSet<Server *> *servers;

/**
 * Contains a user friendly readable string for use in a user interface.
 *
 * Example: Atlanta, United States
 *
 * @return The user friendly location string
 */
- (NSString *)locationString;

/**
 * Calls self.sortedServers:NO
 *
 * @return Array of servers sorted by server name
 */
- (NSArray *)sortedServers;

/**
 * Returns an array of sorted servers fetched from the managed objected context.
 *
 * @param clearCache YES if you want to clear cache and NO if not.
 *
 * @return Array of servers sorted by server name
 */
- (NSArray *)sortedServers:(BOOL)clearCache;

/**
 * A hostname for the POP. Derived from the popName and the popHostname.
 *
 * Example: atl.wlvpn.com
 */
@property (readonly, nonatomic) NSString *hostname;

/**
 * Sets the POP hostname for all city objects. Used when you get the hostname for the City.
 *
 * @param hostname The hostname to set for all pops
 */
+ (void)setPopHostname:(NSString *)hostname;

@end

NS_ASSUME_NONNULL_END
