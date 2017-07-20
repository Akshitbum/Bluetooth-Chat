//
//  AppDelegate.h
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectivityManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define _gAppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ConnectivityManager *connectivityManager;



@end

