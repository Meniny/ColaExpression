//
//  AppDelegate.
//  ColaExpressionSample
//
//  Created by Meniny on 2017-07-14.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import ColaExpression

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        isMatch()
        matches()
        replace()
        
        return true
    }
    
    func isMatch() {
        
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let str = "admin@meniny.cn"
        
        let cola = ColaExpression(pattern)
        if cola.isMatch(with: str) {
            print("\(str) is a valid email")
        }
        
        if str.isMatch(pattern: pattern) {
            print("\(str) is a valid email")
        }
        
        
    }
    
    func matches() {
        
        let pattern = "[a-z]{3}"
        let str = "AAAbbbCCCdddEEEfff"
        
        let cola = ColaExpression(pattern)
        let matches1 = cola.matches(of: str)
        print(matches1)
        
        let matches2 = str.matches(pattern: pattern)
        print(matches2)
    }
    
    func replace() {
        
        let pattern = "[a-z]"
        let str = "AAAbbbCCCdddEEEfff"
        let replacement = "-"
        
        let cola = ColaExpression(pattern)
        let replaced1 = cola.replaceOccurences(in: str, with: replacement)
        print(replaced1)
        
        let replaced2 = str.replaceOccurences(matches: pattern, with: replacement)
        print(replaced2)
        
        let string = "<p class=\"some-class\">// Do <strong>any</strong> additional setup after loading the view, typically from a nib.</p>"
        print("Original: \(string)")
        print(string.stringByReplacingMatches(with: "<[^<>]+>"))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

