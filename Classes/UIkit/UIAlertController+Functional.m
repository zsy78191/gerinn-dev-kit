//
//  DDAlertViewController.m
//  Follow-Up
//
//  Created by 张超 on 2017/11/9.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIAlertController+Functional.h"

@implementation UIAlertController (Functional)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIAlertController * _Nonnull (^)(void))alert
{
    return ^{
        return UI_Alert();
    };
}

+ (UIAlertController * _Nonnull (^)(void))actionSheet
{
    return ^{
        return UI_ActionSheet();
    };
}


- (UIAlertController *(^)(NSString *))titled
{
    return ^ (NSString* j) {
        self.title = j;
        return self;
    };
}

- (UIAlertController *(^)(NSString *))descripted
{
    return ^ (NSString* j) {
        self.message = j;
        return self;
    };
}

- (UIAlertController *(^)(NSString *,void (^ __nullable)(UIAlertAction *action, UIAlertController* _Nonnull)))action
{
    return ^ (NSString* j,  void (^ __nullable block)(UIAlertAction *action, UIAlertController* _Nonnull)) {
        [self addAction:[UIAlertAction actionWithTitle:j style:0 handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(action,self);
            }
        }]];
        return self;
    };
}

- (UIAlertController * _Nonnull (^)(NSString * _Nonnull, void (^ _Nullable)(UIAlertAction * _Nonnull, UIAlertController * _Nonnull)))recommend
{
    return ^ (NSString* j,  void (^ __nullable block)(UIAlertAction *action, UIAlertController* _Nonnull)) {
        [self addAction:[UIAlertAction actionWithTitle:j style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(action,self);
            }
        }]];
        return self;
    };
}

- (UIAlertController * _Nonnull (^)(NSString * _Nonnull, void (^ _Nullable)(UIAlertAction * _Nonnull)))cancel
{
    return ^ (NSString* j,  void (^ __nullable block)(UIAlertAction *action)) {
        [self addAction:[UIAlertAction actionWithTitle:j style:1 handler:block]];
        return self;
    };
}

- (void (^)(__kindof UIViewController * _Nonnull))show
{
    return ^(__kindof UIViewController * _Nonnull vc){
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc presentViewController:self animated:YES completion:nil];
        });
    };
}

- (UIAlertController * _Nonnull (^)(NSString * _Nonnull, void (^ _Nullable)(UITextField * _Nonnull)))input
{
    return ^ (NSString* j,  void (^ __nullable block)(UITextField * _Nonnull field)) {
        [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = j;
            if (block) {
                block(textField);
            }
        }];
        return self;
    };
}

UIAlertController* UI_Alert(){
    @autoreleasepool{
        UIAlertController* d = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:1];
        return d;
    }
}

UIAlertController* UI_ActionSheet(){
    @autoreleasepool{
        UIAlertController* d = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
        return d;
    }
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
