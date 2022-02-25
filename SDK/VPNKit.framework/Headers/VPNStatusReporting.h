//
//  VPNStatusReporting.h
//  VPNKit
//
//  Created by Zeph Cohen on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VPNAPIManager;
@class VPNConfiguration;

/**
 *  This protocol's only purpose is to act as a common interface between all the status reporting protocols. 
 *  These include:
 *      VPNAccountStatusReporting, VPNConfigurationStatusReporting, VPNConnectionStatusReporting, VPNHelperStatusReporting, 
 *      VPNServerStatusReporting, VPNSpeedTestStatusReporting
 */
@protocol VPNStatusReporting <NSObject>
@required
@property (nonatomic, null_unspecified) VPNAPIManager* apiManager;
@end
