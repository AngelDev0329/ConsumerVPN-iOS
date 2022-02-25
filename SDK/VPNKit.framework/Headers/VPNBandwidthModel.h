/*
 * VPNBandwidthModel.h
 * VPNKit
 * 
 * @copyright 2018 WLVPN. All rights reserved.
*/

#import <Foundation/Foundation.h>


@interface VPNBandwidthModel : NSObject

@property (strong) NSNumber *totalUpload;
@property (strong) NSNumber *totalDownload;

@property (strong) NSNumber *lastUpload;
@property (strong) NSNumber *lastDownload;

@end
