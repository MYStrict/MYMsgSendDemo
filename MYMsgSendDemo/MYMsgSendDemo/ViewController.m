//
//  ViewController.m
//  MYMsgSendDemo
//
//  Created by yan ma on 2020/10/20.
//  Copyright © 2020 MYStrict. All rights reserved.
//

#import "ViewController.h"

#import "Father.h"
#import "Son.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testBtnClick:(id)sender {
    
    Father *ff = [[Father alloc] init];
    [ff playTheGuitar];
    
}



@end
