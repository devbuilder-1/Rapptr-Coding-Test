//
//  ChatClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "ChatClient.h"
#import "JSONModelLib.h"
#import "Message.h"




@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@end


@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<NSDictionary *> *))completion withError:(void (^)(NSString *error))errorBlock
{
    
    // NSArray * returnMessages = [Message init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil)
        {
            NSError *jsonError;
            NSString * convertedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ChatData * data = [[ChatData alloc] initWithString:convertedStr error:&jsonError];
            
            //NSLog(@"%@", data);
            
            for (Message *m in data.data){
                [returnArray addObject:m];
            }
            
    
            completion(returnArray);
        }
        
    }];
    
    [postDataTask resume];
    
    
}

@end
