//
//  DDAlertViewController.h
//  Follow-Up
//
//  Created by 张超 on 2017/11/9.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Functional)
{
    
}

UIAlertController* UI_Alert(void);
UIAlertController* UI_ActionSheet(void);

@property (nonatomic, readonly, class)  UIAlertController* (^actionSheet)(void);
@property (nonatomic, readonly, class)  UIAlertController* (^alert)(void);

@property (nonatomic, readonly)  UIAlertController* (^titled)(NSString* title);
@property (nonatomic, readonly)  UIAlertController* (^descripted)(NSString* description);
@property (nonatomic, readonly)  UIAlertController* (^action)(NSString* title,void (^ __nullable)(UIAlertAction *action,UIAlertController* alert));
@property (nonatomic, readonly)  UIAlertController* (^recommend)(NSString* title,void (^ __nullable)(UIAlertAction *action,UIAlertController* alert));
@property (nonatomic, readonly)  UIAlertController* (^cancel)(NSString* title,void (^ __nullable)(UIAlertAction *action));
@property (nonatomic, readonly)  UIAlertController* (^input)(NSString* title,void (^ __nullable)(UITextField *field));
@property (nonatomic, readonly)  void (^show)(__kindof UIViewController* vc);

@end

NS_ASSUME_NONNULL_END
