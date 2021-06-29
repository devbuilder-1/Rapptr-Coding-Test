//
//  ChatClient.h
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import <Foundation/Foundation.h>
#import "Message.h"
#import <UIKit/UIKit.h>


@interface ChatClient : NSObject
- (void)fetchChatData:(void (^)(NSArray<NSDictionary *> *))completion withError:(void (^)(NSString *error))errorBlock;
@end
