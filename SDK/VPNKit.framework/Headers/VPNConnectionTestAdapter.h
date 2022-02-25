//
//  VPNConnectionTestAdapter.h
//  VPNKit
//
//  Created by Joshua Shroyer on 11/23/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPNConnectionTestAdapter : NSObject <VPNConnectionAdapterProtocol>

/**
 * Stores when the VPN is connected/disconnected
 */
@property (nonatomic, copy) NSDate *connectedDate;

/**
 * Allows the Adapter to report connection status and changes to VPNAPIManager.
 */
@property (nonatomic, copy) VPNStatusHandler statusHandler;

/**
 * Allows the Adapter to report external configuration changes
 */
@property (nonatomic, copy) VPNExternalConfigurationChangedHandler configurationChangedHandler;

@end
