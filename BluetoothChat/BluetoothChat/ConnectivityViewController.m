//
//  ConnectivityViewController.m
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import "ConnectivityViewController.h"
#import "SessionData.h"

@interface ConnectivityViewController ()
-(void)didChangeStateWithNotification:(NSNotification *)notification;

@end

@implementation ConnectivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultSession];
    [self setUpDelegate];
    self.deviceArr = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStateWithNotification:) name:kDidChangeStateNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupDefaultSession {
    [[_gAppDelegate connectivityManager] setPearIdAndSesssionWithDisplayName:[UIDevice currentDevice].name];
    [[_gAppDelegate connectivityManager] advertise:self.switchVisibility.isOn];
}

- (void) setUpDelegate {
    [self.textDeviceName setDelegate:self];
    [self.tableViewConnectedDevices setDelegate:self];
    [self.tableViewConnectedDevices setDataSource:self];
}
- (void)didChangeStateWithNotification:(NSNotification *)notification {
    SessionData *sessionData = (SessionData *)[notification userInfo];
    NSString *displayName = sessionData.peerId.displayName;
    MCSessionState state = [sessionData.sessionState intValue];
    
    // Updating table View based on Data Source
    if(state != MCSessionStateConnecting) {
        if(state == MCSessionStateConnected) {
            [self.deviceArr addObject:displayName];
        }
        else if (state == MCSessionStateNotConnected) {
            if(self.deviceArr.count > 0) {
                NSUInteger index = [self.deviceArr indexOfObject:displayName];
                [self.deviceArr removeObjectAtIndex:index];
            }
        }
        
        [self.tableViewConnectedDevices reloadData];
        BOOL peersExist = ([[[_gAppDelegate connectivityManager].session connectedPeers] count] == 0);
        [self.buttonDisconnect setEnabled:!peersExist];
        [self.textDeviceName setEnabled:peersExist];
    }

    
    
}

- (IBAction)searchDevices {
    [[_gAppDelegate connectivityManager] setupBrowser];
    [[[_gAppDelegate connectivityManager] browserViewController] setDelegate:self];
    [self presentViewController:[_gAppDelegate connectivityManager].browserViewController animated:YES completion:nil];
}

- (IBAction)toggleVisibility {
    [[_gAppDelegate connectivityManager] advertise:self.switchVisibility.isOn];
}

- (IBAction)disconnect {
    [[_gAppDelegate connectivityManager].session disconnect];
    [self.textDeviceName setEnabled:YES];
    
    [self.deviceArr removeAllObjects];
    [self.tableViewConnectedDevices reloadData];
}

- (void) browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [[_gAppDelegate connectivityManager].browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [[_gAppDelegate connectivityManager].browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textDeviceName resignFirstResponder];
    
    [_gAppDelegate connectivityManager].peerId = nil;
    [_gAppDelegate connectivityManager].session = nil;
    [_gAppDelegate connectivityManager].browserViewController = nil;
    
    if(self.switchVisibility.isOn) {
        [[_gAppDelegate connectivityManager].advertiserAssistant stop];
        
    }
    
    [_gAppDelegate connectivityManager].advertiserAssistant = nil;
    [[_gAppDelegate connectivityManager] setPearIdAndSesssionWithDisplayName:self.textDeviceName.text];
    [[_gAppDelegate connectivityManager] setupBrowser];
    [[_gAppDelegate connectivityManager] advertise:self.switchVisibility.isOn];
    

    
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.deviceArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text = [self.deviceArr objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end
