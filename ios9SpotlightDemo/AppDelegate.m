//
//  AppDelegate.m
//  ios9SpotlightDemo
//
//  Created by Rocky on 15/9/28.
//  Copyright © 2015年 Rocky. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     NSLog(@"%f",[UIDevice currentDevice].systemVersion.floatValue);
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
       
        [self setSpotlight];
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)deleteSearchableItemsWithIdentifiers:(NSArray<NSString *> *)identifiers completionHandler:(void (^ __nullable)(NSError * __nullable error))completionHandler{

}

- (void)deleteSearchableItemsWithDomainIdentifiers:(NSArray<NSString *> *)domainIdentifiers completionHandler:(void (^ __nullable)(NSError * __nullable error))completionHandler{

}

- (void)deleteAllSearchableItemsWithCompletionHandler:(void (^ __nullable)(NSError * __nullable error))completionHandler{

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    
    NSString *idetifier  = userActivity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    NSLog(@"%@",idetifier);
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([idetifier isEqualToString:@"firstItem"]) {
        
        FirstViewController *fistVc = [stroy instantiateViewControllerWithIdentifier:@"firstView"];
        [nav pushViewController:fistVc animated:YES];
        
    }else if ([idetifier isEqualToString:@"secondItem"]){
        
        SecondViewController *secondVc = [stroy instantiateViewControllerWithIdentifier:@"secondView"];
        [nav pushViewController:secondVc animated:YES];
    }
    
    return YES;
}

- (void)setSpotlight{
    /*应用内搜索，想搜索到多少个界面就要创建多少个set ，每个set都要对应一个item*/
    CSSearchableItemAttributeSet *firstSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"firstSet"];
    //标题
    firstSet.title = @"测试firstView";
    //详细描述
    firstSet.contentDescription = @"测试firstView哈哈哈哈哈哈哈";
    //关键字，
    NSArray *firstSeachKey = [NSArray arrayWithObjects:@"first",@"测试",@"firstView", nil];
    firstSet.contactKeywords = firstSeachKey;
    
    CSSearchableItemAttributeSet *secondSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"secondSet"];
    secondSet.title = @"测试SecondView";
    secondSet.contentDescription = @"测试secondView哈哈哈哈哈哈哈哈";
    NSArray *secondArrayKey = [NSArray arrayWithObjects:@"second",@"测试",@"secondeVIew", nil];
    secondSet.contactKeywords = secondArrayKey;
    
    //UniqueIdentifier每个搜索都有一个唯一标示，当用户点击搜索到得某个内容的时候，系统会调用代理方法，会将这个唯一标示传给你，以便让你确定是点击了哪一，方便做页面跳转
    //domainIdentifier搜索域标识，删除条目的时候调用的delegate会传过来这个值
    CSSearchableItem *firstItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"firstItem" domainIdentifier:@"first" attributeSet:firstSet];
    
    CSSearchableItem *secondItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"secondItem" domainIdentifier:@"second" attributeSet:secondSet];
    
    NSArray *itemArray = [NSArray arrayWithObjects:firstItem,secondItem, nil];
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:itemArray completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"设置失败%@",error);

        }else{
        
            NSLog(@"设置成功");
        }
    }];
    
}
@end
