//
//  ProtocolType.h
//  VPNKit
//
//  Created by Kevin Hallmark on 6/23/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Represents a protocol type and associated properties required to connect to a vpn server
 */
@interface ProtocolType : NSManagedObject

/**
 * The cipher supported by this ProtocolType
 */
@property (nullable, nonatomic, retain) NSString *cipher;

/**
 * The protocol name (openvpn, sstp, l2tp, pptp, ikev2)
 */
@property (nullable, nonatomic, retain) NSString *name;

/**
 * The port used to connect this protocol
 */
@property (nullable, nonatomic, retain) NSString *port;

/**
 * The protocol (TCP/UDP)
 */
@property (nullable, nonatomic, retain) NSString *protocol;

/**
 * Formerly used by MagicalRecord and now used for compatibility.
 */
@property (nullable, nonatomic, retain) NSNumber *protocolTypeID;

/**
 * Does this protocol support scramble? (openvpn only)
 */
@property (nullable, nonatomic, retain) NSNumber *scrambleSupported;

/**
 * The scramble word to use when connecting to this protocol configuration
 */
@property (nullable, nonatomic, retain) NSString *scrambleWord;

/**
 * The capacity as % integer. This is not used and is kept for legacy support.
 */
@property (nullable, nonatomic, retain) NSNumber *capacity;

/**
 * A set of all servers (ServerProtocol = many to many join table) that contain this protocol
 */
@property (nullable, nonatomic, retain) NSSet<ServerProtocol *> *serverProtocols;

@end

NS_ASSUME_NONNULL_END