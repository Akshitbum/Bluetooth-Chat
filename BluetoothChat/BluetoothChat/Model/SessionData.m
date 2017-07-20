//
//  SessionData.m
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import "SessionData.h"


@implementation SessionData

- (id)initWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if(self){
        self.peerId = [dict objectForKey:@"peerId"];
        self.sessionState = [dict objectForKey:@"sessionState"];
    }
    
    return self;
}

@end
