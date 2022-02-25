//
//  ServerProtocol.h
//  VPNKit
//
//  Created by Kevin Hallmark on 6/23/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProtocolType, Server;

NS_ASSUME_NONNULL_BEGIN

/**
 * Represents a relationship between a Server object and a ProtocolType object.
 */
@interface ServerProtocol : NSManagedObject

/**
 * The ProtocolType of this relation
 */
@property (nullable, nonatomic, retain) ProtocolType *type;

/**
 * The Server for this relation
 */
@property (nullable, nonatomic, retain) Server *server;

/**
 * The capacity as % integer. This value is unique per server.
 */
@property (nullable, nonatomic, retain) NSNumber *capacity;

/**
 * Deprecated MagicalRecord identifier
 */
@property (nullable, nonatomic, retain) NSString *serverProtocolID;


@end

NS_ASSUME_NONNULL_END