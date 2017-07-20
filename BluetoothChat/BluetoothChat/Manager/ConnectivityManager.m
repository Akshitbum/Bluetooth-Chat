//
//  ConnectivityManager.m
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import "ConnectivityManager.h"
#import "SessionData.h"

@implementation ConnectivityManager

- (id)init {
    self = [super init];
    
    if(self) {
        self.peerId = nil;
        self.session = nil;
        self.browserViewController = nil;
        self.advertiserAssistant = nil;
    }
    
    return self;
}

-(void)setPearIdAndSesssionWithDisplayName:(NSString *)displayName {
    self.peerId = [[MCPeerID alloc] initWithDisplayName:displayName];
    self.session = [[MCSession alloc] initWithPeer:self.peerId];
    self.session.delegate = self;
}

-(void)setupBrowser {
    self.browserViewController = [[MCBrowserViewController alloc] initWithServiceType:@"chat-text" session:self.session];
}

-(void)advertise:(BOOL)shouldAdvertise{
    if(shouldAdvertise) {
        self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat-text" discoveryInfo:nil session:self.session];
        [self.advertiserAssistant start];
    }
    else {
        [self.advertiserAssistant stop];
        self.advertiserAssistant = nil;
    }
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    NSDictionary *dictionary = @{@"peerId": peerID,
                                 @"sessionState": [NSNumber numberWithInt:state]};
    
    SessionData *data = [[SessionData alloc] initWithDictionary:dictionary];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidChangeStateNotification object:nil userInfo:data];
}


-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    
}


-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}


-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}


-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

@end
