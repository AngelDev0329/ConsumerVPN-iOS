//
//  AppDelegate.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/8/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var apiManager:           VPNAPIManager!
    var vpnConfiguration:     VPNConfiguration?
    
    // MARK: Helper Method
    static func sharedDelegate() -> AppDelegate {
        // This should cause a crash if it isn't correct, hence the force unwrap.
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: System Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(for: self)
        
        // Setup the rest of the application now
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = .navigationItem
        navBarAppearance.barTintColor = .navigationBar
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.navigationItem]
        
        // Initialize the APIManager using helper Objc object.
		apiManager = SDKInitializer.initializeAPIManager(
			withBrandName: Theme.brandName,
			apiKey:Theme.apiKey,
			andSuffix: Theme.usernameSuffix
		)
		
        vpnConfiguration = apiManager.vpnConfiguration
        
        // set the default encryption to 256 if one isn't already set
        if vpnConfiguration!.hasOption(forKey: kIKEv2Encryption) == false {
            vpnConfiguration!.setOption(kVPNEncryptionAES256, forKey: kIKEv2Encryption)
        }
        
        // Create the first view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Determine if we should initially show the Login View Controller or start immediately on the DashboardViewController
        let initialViewController: UIViewController
        
        // We should crash if this doesn't work properly
        let wlNavigationController = storyboard.instantiateViewController(withIdentifier: "WLVPNNavigationController") as! WLVPNNavigationController
        wlNavigationController.apiManager = apiManager
        wlNavigationController.vpnConfiguration = vpnConfiguration
        initialViewController = wlNavigationController
        
        window!.rootViewController = initialViewController
        window!.makeKeyAndVisible()
        
        // If the user isn't valid, we'll need to display the login page over the dashboard as our initial starting point
        if vpnConfiguration?.user == nil {
            // performing selector after delay prevents the `unbalanced calls` warning in the console log
            perform(#selector(AppDelegate.presentLoginViewController), with: nil, afterDelay: 0.0)
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        UserDefaults.standard.synchronize()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UserDefaults.standard.set(nil, forKey: Theme.loginErrorKey)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Generic Helper Methods
extension AppDelegate {
    
    /// This method is called when the application is logged out of successfully or within the
    /// didFinishLaunchingWithOptions method if the user doesn't exist.
    @objc fileprivate func presentLoginViewController() {
        // get the current view controller's navigation controller and present the login view controller over it.
        // Pop to root on current's stack when done
        guard let currentViewController = UIViewController.currentViewController else {
            return
        }
        
        // ensure this isn't the login view controller already
        guard currentViewController is LoginViewController == false else {
            return
        }
        
        // display the login view controller over the dashboard
        // to do this, get the root controller (nav controller) and pop to root (dashboard)
        // once that's done, present the
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.apiManager = apiManager
        loginViewController.vpnConfiguration = vpnConfiguration
        let navController = UINavigationController(rootViewController: loginViewController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.setNavigationBarHidden(true, animated: false)
        
        
        
        currentViewController.present(navController, animated: true) {
           // navController.setNavigationBarHidden(false, animated: false)
            _ = currentViewController.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - VPNAccountStatusReporting
extension AppDelegate: VPNAccountStatusReporting {
    
    /// Used to Ensure Account preferences are set back to defaults
    func statusLogoutSucceeded() {
        UserDefaults.standard.set(0, forKey: Theme.filterPingRangeKey)
        UserDefaults.standard.set(0, forKey: Theme.sortOptionKey)
        UserDefaults.standard.set(nil, forKey: Theme.lastUpdateKey)
        UserDefaults.standard.synchronize()
        
        presentLoginViewController()
    }
    
    func statusLoginSucceeded(_ notification: Notification) {
    }
    
    func statusLogoutWillBegin() {
    }
}
