//
//  PickerTools.h
//  PickerViewUtil
//
//  Created by Nilam on 10/23/13.
//  Copyright (c) 2013 Nilam. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PickerViewCompletionHandler) ( NSString *value, BOOL valueChanged);

@interface PickerTools : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>

+(PickerTools *)shareModel;
- (void)showPickerViewWith:(UIViewController *)myViewController CompletionHandler:(PickerViewCompletionHandler)completionHandler;
@end
