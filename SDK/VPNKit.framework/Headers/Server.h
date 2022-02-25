//
//  Server.h
//  VPNKit
//
//  Created by Kevin Hallmark on 12/3/15.
//  @copyright 2018 WLVPN All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City;
@class Country;
@class ServerProtocol;

@interface Server : NSManagedObject

/**
 * The name of the server. Usually the hostname
 */
@property (nullable, nonatomic, retain) NSString *name;

/**
 * The % capacity in use expressed as an integer.
 */
@property (nullable, nonatomic, retain) NSNumber *capacity;

/**
 * The name of the city that contains this server
 */
@property (nullable, nonatomic, retain) NSString *cityName;

/**
 * The name of the country that contains this server
 */
@property (nullable, nonatomic, retain) NSString *countryName;

/**
 * The full hostname of the server
 */
@property (nullable, nonatomic, retain) NSString *hostname;

/**
 * A URL that contains a flag image you can use.
 */
@property (nullable, nonatomic, retain) NSString *icon;

/**
 * The IP address of the server
 */
@property (nullable, nonatomic, retain) NSString *ipAddress;

/**
 * The last time the information about this server was update
 */
@property (nullable, nonatomic, retain) NSDate   *lastUpdated;

/**
 * The start time for scheduled maintenance on this server
 */
@property (nullable, nonatomic, retain) NSDate   *scheduledMaintenance;

/**
 * The latitude of the server
 */
@property (nullable, nonatomic, retain) NSNumber *latitude;

/**
 * The longitude of the server
 */
@property (nullable, nonatomic, retain) NSNumber *longitude;

/**
 * Is this server in maintenance?
 */
@property (nullable, nonatomic, retain) NSNumber *maintenance;

/**
 * The preshared key used to connect to this server
 */
@property (nullable, nonatomic, retain) NSString *presharedKey;

/**
 * Returns the hostname for the server. Originally used by magicalrecord but we removed that dependency.
 */
@property (nullable, nonatomic, retain) NSString *serverID;

/**
 * The server status. Returns 1 if not in maintenance and 0 if in maintenance.
 */
@property (nullable, nonatomic, retain) NSNumber *status;

/**
 * The server visibility (in the server list). Returns 1 if not in maintenance and 0 if in maintenance.
 */
@property (nullable, nonatomic, retain) NSNumber *visible;

/**
 * The city that contains this server
 */
@property (nullable, nonatomic, retain) City     *city;

/**
 * The country that contains this server
 */
@property (nullable, nonatomic, retain) Country  *country;

/**
 * A list of detailed properties about our protocol configuration
 */
@property (nullable, nonatomic, retain) NSSet<ServerProtocol *> *protocols;

/**
 * This function is a hack so that the same code could be used to handle Countries/Cities/Servers.
 *
 * @return An empty array because a server doesn't have servers.
 */
- (nonnull NSArray<Server*> *)servers;

/**
 * Returns the first component of the hostname
 *
 * Example: nyc-a43
 *
 * @return The first component of the hostname
 */
- (nullable NSString *)formattedServerName;

@end

