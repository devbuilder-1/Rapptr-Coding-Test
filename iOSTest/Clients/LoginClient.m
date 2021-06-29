//
//  LoginClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "LoginClient.h"

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 **/

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary *))completion
{
    // NSArray * returnMessages = [Message init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:60];
    
    
    NSString *postData = [NSString stringWithFormat:@"&email=%@&password=%@", email, password];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
   
    
    
    NSMutableDictionary *returnDictionary = [[NSMutableDictionary alloc] init];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil)
        {
            
            NSString * convertedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", convertedStr);
            
            if ([convertedStr containsString:@"Login Successful!"]){
                returnDictionary[@"sucess"] = @"Yes";
            }
            
            else if ([convertedStr containsString:@"Incorrect Email or Password!"]){
                returnDictionary[@"error"] = @"Incorrect Email or Password!";
            }
            
            else {
                returnDictionary[@"error"] = error;
            }
            
            
            
        }
        
        if (error != nil) {
            returnDictionary[@"error"] = error;
        }
        
        completion(returnDictionary);
        
    }];
    
    [postDataTask resume];
}

@end
