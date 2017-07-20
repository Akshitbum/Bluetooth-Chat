//
//  ConnectivityManager.h
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ConnectivityManager : NSObject<MCSessionDelegate>

@property(nonatomic, strong) MCPeerID *peerId;
@property(nonatomic, strong) MCSession *session;
@property(nonatomic, strong) MCBrowserViewController *browserViewController;
@property(nonatomic, strong) MCAdvertiserAssistant *advertiserAssistant;


-(void)setPearIdAndSesssionWithDisplayName:(NSString *)displayName;
-(void)setupBrowser;
-(void)advertise:(BOOL)shouldAdvertise;

@end
