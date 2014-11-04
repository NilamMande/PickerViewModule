//
//  ViewController.m
//  PickerViewUtil
//
//  Created by Nilam on 10/23/13.
//  Copyright (c) 2013 Nilam. All rights reserved.
//

#import "ViewController.h"
#import "PickerTools.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbl_Value;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)showPicker:(id)sender {
    [[PickerTools shareModel] showPickerViewWith:self CompletionHandler:^(NSString *value, BOOL valueChanged) {
        if (valueChanged) {
            self.lbl_Value.text = value;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
