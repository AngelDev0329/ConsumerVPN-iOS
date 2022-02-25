//
//  Analytics.h
//  VPNKit
//
//  Created by Kevin Hallmark on 3/8/16.
//  Copyright © 2016 WLVPN. All rights reserved.
//

@import Foundation;

#ifndef Analytics_h
#define Analytics_h

#pragma mark - Analytics Events

static NSString * const kConnectEvent      = @"Connect";
static NSString * const kDisconnectEvent   = @"Disconnect";
static NSString * const kScreenViewedEvent = @"Screen Viewed";

#pragma mark - Analytics Attributes

static NSString * const kConnectLocationAttribute    = @"ConnectLocation";
static NSString * const kDisconnectLocationAttribute = @"DisconnectLocation";
static NSString * const kScreenDisplayedAttribute    = @"ScreenDisplayed";

#pragma mark - Analytics Screens

static NSString *const kQuickConnectScreen       = @"QuickConnect";
static NSString *const kServerListScreen         = @"ServerList";
static NSString *const kServerListFilterScreen   = @"ServerListFilter";
static NSString *const kServerListMapScreen      = @"ServerListMap";
static NSString *const kServerListFavoriteScreen = @"ServerListFavorite";
static NSString *const kAccountScreen            = @"Account";
static NSString *const kSettingsScreen           = @"Settings";

#pragma mark - Analytics Connect Locations

static NSString * const kQuickConnectLocation       = @"QuickConnect";
static NSString * const kTodayExtensionLocation     = @"TodayExtension";
static NSString * const kServerListServerLocation   = @"ServerListServer";
static NSString * const kServerListPopLocation      = @"ServerListPop";
static NSString * const kServerFilterServerLocation = @"ServerFilterServer";
static NSString * const kServerFilterPopLocation    = @"ServerFilterPop";
static NSString * const kServerMapServerLocation    = @"ServerMapServer";
static NSString * const kServerMapPopLocation       = @"ServerMapPop";
static NSString * const kFavoriteTabLocation        = @"FavoriteTab";
static NSString * const kMiniUILocation             = @"MiniUI";
static NSString * const kToolbarLocation            = @"Toolbar";
static NSString * const kTouchbarLocation           = @"Touchbar";
static NSString * const kDockMenuLocation           = @"DockMenu";
static NSString * const kChangeIPLocation           = @"ChangeIPLocation";

#endif /* Analytics_h */
