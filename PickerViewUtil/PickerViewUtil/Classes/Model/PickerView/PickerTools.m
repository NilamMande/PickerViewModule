//
//  PickerTools.m
//  PickerViewUtil
//
//  Created by Nilam on 10/23/13.
//  Copyright (c) 2013 Nilam. All rights reserved.
//

#import "PickerTools.h"

@interface PickerTools ()
{
    UIPickerView* myPickerView;
    UIView *maskView;
    UIToolbar *providerToolbar;
    NSMutableArray *pickerArray;
    NSString *selectedValue;
}
@property (nonatomic, strong) PickerViewCompletionHandler completionHandler;
@end

@implementation PickerTools
static PickerTools *shareModelInstance = nil;

+(PickerTools *)shareModel
{
    @synchronized(self)
    {
        static dispatch_once_t pred;
        dispatch_once (&pred, ^{shareModelInstance = [[self alloc] init];});
    }
    return shareModelInstance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        selectedValue = @"";
        pickerArray = [[NSMutableArray alloc] init];
        for(int pickerValue = 1; pickerValue <= 20; pickerValue++)
        {
            [pickerArray addObject:[NSString stringWithFormat:@"%d",pickerValue]];
        }
    }
    return self;
}

- (void)showPickerViewWith:(UIViewController *)myViewController
         CompletionHandler:(PickerViewCompletionHandler)completionHandler
{
    self.completionHandler = [completionHandler copy];
    [self createPickerView:myViewController];
}

- (void) createPickerView:(UIViewController *)myViewController
{
    CGRect frame =CGRectMake(0,0,
                             myViewController.view.bounds.size.width,
                             myViewController.view.bounds.size.height);
    maskView = [[UIView alloc] initWithFrame:frame];
    [maskView setBackgroundColor:[UIColor colorWithRed:0.0
                                                 green:0.0
                                                  blue:0.0
                                                 alpha:0.5]];
    [myViewController.view addSubview:maskView];
    
    CGRect frameToolBar =CGRectMake(0,
                                    myViewController.view.bounds.size.height-244,
                                    myViewController.view.bounds.size.width,
                                    44);
    providerToolbar = [[UIToolbar alloc] initWithFrame:frameToolBar];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(doneWithSelection:)];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                               target:self
                               action:@selector(dismissPickerView:)];
    
    providerToolbar.items = @[cancel,
                              [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                               target:nil
                               action:nil],
                              done];
    
    providerToolbar.barStyle = UIBarStyleBlackOpaque;
    [myViewController.view addSubview:providerToolbar];
    [myViewController.view addSubview:[self initialisePicker:myViewController]];
}

- (UIPickerView*)initialisePicker:(UIViewController *)myViewController
{
    CGRect pickerFrame = CGRectMake(0,myViewController.view.bounds.size.height-200,0,0);
    myPickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor = [UIColor colorWithRed:1.0
                                                   green:1.0
                                                    blue:1.0
                                                   alpha:0.5];
    return myPickerView;
}

-(IBAction)doneWithSelection:(id)sender
{
    [maskView removeFromSuperview];
    [myPickerView removeFromSuperview];
    [providerToolbar removeFromSuperview];
    
    //return to main flow
    if (self.completionHandler) {
        self.completionHandler(selectedValue, YES);
    }
}
- (void)dismissPickerView:(id)sender
{
    [maskView removeFromSuperview];
    [myPickerView removeFromSuperview];
    [providerToolbar removeFromSuperview];
    
    //return to main flow
    if (self.completionHandler) {
        self.completionHandler(nil, NO);
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    selectedValue = [pickerArray objectAtIndex:row];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerArray objectAtIndex:row];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}
@end
