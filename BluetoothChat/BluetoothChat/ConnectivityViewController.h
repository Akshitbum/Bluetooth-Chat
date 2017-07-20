//
//  ConnectivityViewController.h
//  BluetoothChat
//
//  Created by Akshit Bum on 20/07/17.
//  Copyright © 2017 Akshit Bum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ConnectivityViewController : UIViewController<MCBrowserViewControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textDeviceName;
@property (weak, nonatomic) IBOutlet UISwitch *switchVisibility;
@property (weak, nonatomic) IBOutlet UITableView *tableViewConnectedDevices;
@property (weak, nonatomic) IBOutlet UIButton *buttonDisconnect;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearchDevices;
@property (nonatomic, strong) NSMutableArray *deviceArr;

- (IBAction)searchDevices;
- (IBAction)toggleVisibility;
- (IBAction)disconnect;


@end

