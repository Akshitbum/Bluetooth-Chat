//
//  SessionData.h
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface SessionData : NSDictionary

@property(nonatomic, strong) MCPeerID *peerId;
@property(nonatomic) NSNumber *sessionState;
- (id)initWithDictionary:(NSDictionary *) dict;


@end
