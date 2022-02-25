//
//  Country.h
//  VPNKit
//
//  Created by Kevin Hallmark on 1/4/16.
//  @copyright 2018 WLVPN All rights reserved.
//

@import Foundation;
@import CoreData;

// This ensures compatibility with either OSX or iOS
#if TARGET_OS_IPHONE
#define CountryFlagImage UIImage
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC && !TARGET_OS_IPHONE
#define CountryFlagImage NSImage
@import Cocoa;
#endif

@class City, Server;

NS_ASSUME_NONNULL_BEGIN

/**
 * A country where we have Cities/Servers.
 */
@interface Country : NSManagedObject

/**
 * The ISO-3166-1 alpha-2 country code for the country.
 */
@property (nullable, nonatomic, retain) NSString *countryID;

/**
 * The country name. Set to the localizedName on fetch/insert.
 */
@property (nullable, nonatomic, retain) NSString *name;

/**
 * T
 */
@property (nullable, nonatomic, retain) NSSet<City *> *cities;
@property (nullable, nonatomic, retain) NSSet<Server *> *servers;

/**
 * This calls a function that returns a localized country name
 */
@property (readonly) NSString *localizedName;

/**
 * An image of the flag that can be used by consumers of the country
 */
@property (readonly) CountryFlagImage *flagImage;

/**
 * Calls self.sortedCities:NO
 *
 * @return Array of cities sorted by city name
 */
- (NSArray *)sortedCities;

/**
 * Returns an array of sorted cities fetched from the managed objected context.
 *
 * @param clearCache YES if you want to clear cache and NO if not.
 *
 * @return Array of cities sorted by city name
 */
- (NSArray *)sortedCities:(BOOL)clearCache;

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

@end

NS_ASSUME_NONNULL_END
