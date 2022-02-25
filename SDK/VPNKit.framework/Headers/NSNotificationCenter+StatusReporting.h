//
//  NSNotificationCenter+StatusReporting.h
//  VPNKit
//
//  Created by Joshua Shroyer on 9/9/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VPNStatusReporting;

/**
 * Provides a convenient interface for adding NSNotificationCenter listeners if a class conforms to our notification
 * protocols.
 */
@interface NSNotificationCenter (StatusReporting)

/**
 * Add an Observer to Notification Center provided the observer conforms to at least one of the child protocols of VPNStatusReporting.
 *  This method will link up each VPNKit event with the associated protocol method provided it is implemented on the observer.
 *
 * @param observer The object wanting to listen for the VPNStatusReporting notifications
 */
- (void)addObserverForVPNStatusReporting:(nonnull id<VPNStatusReporting>) observer;

/**
 * Remove an existing Observer from NotificationCenter where the observer conforms to at least one of the child protocols of VPNStatusReporting
 *  This method will remove only those notifications associated with the VPNKit events.
 *
 * @param observer The object wanting to unsubscribe from the VPNStatusReporting notifications
 */
- (void)removeObserverForVPNStatusReporting:(nonnull id<VPNStatusReporting>) observer;

@end
