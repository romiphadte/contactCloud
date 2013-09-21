//
//  SWDataUploader.m
//  ContactCloud
//
//  Created by Siddhant Dange on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWDataUploader.h"
#import "VBAddressBookGrabber.h"
#import <Parse/Parse.h>

@interface SWDataUploader ()

@property (nonatomic, strong) VBAddressBookGrabber *grabber;

@end

@implementation SWDataUploader



-(void)uploadAddressBookWithCompletion:(void(^)(NSError*, NSArray*))completionBlock{
    
    NSArray* addressBook = [self.grabber getAddressBook];
    
    __block NSError *errorVal = nil;
    for (NSDictionary *person in addressBook) {
        PFObject *testObject = [PFObject objectWithClassName:@"People"];
        if(person[@"First"] && person[@"Last"] && person[@"Phone"][0]){
            [testObject setObject:((NSString*)person[@"First"]).lowercaseString forKey:@"firstname"];
            [testObject setObject:((NSString*)person[@"Last"]).lowercaseString forKey:@"lastname"];
            [testObject setObject:[NSString stringWithFormat:@"%@ %@", ((NSString*)person[@"First"]).lowercaseString, ((NSString*)person[@"Last"]).lowercaseString] forKey:@"fullname"];
            NSString *rawPhoneNumber = person[@"Phone"][0];
            NSString *cleanNumber = [self cleanedPhoneNumber:rawPhoneNumber];
            [testObject setObject:cleanNumber forKey:@"number"];
            [testObject setObject:@(0) forKey:@"strength"];
            
            if(person[@"Email"][0]){
                [testObject setObject:person[@"Email"][0] forKey:@"email"];
            }
            
            [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    NSLog(@"error saving %@ : %@", testObject, error);
                    errorVal = error;
                }
            }];
        }
    }
    
    completionBlock(errorVal, addressBook);
}

-(NSString*)cleanedPhoneNumber:(NSString*)rawNumber{
    NSMutableString *cleanedNumber = @"".mutableCopy;
    for (int i = rawNumber.length - 1; i >= 0; i--) {
        char current = [rawNumber characterAtIndex:i];
        
        if(current != '-' && current != ' ' && current != '(' && current != ')' && current != '+'){
            [cleanedNumber appendString:[NSString stringWithFormat:@"%c", current]];
        }
    }
    
    if(cleanedNumber.length > 10){
        cleanedNumber = [cleanedNumber substringFromIndex:1].mutableCopy;
    }
    
    return cleanedNumber;
}

-(SWDataUploader*)init{
    self = [super init];
    
    if(self) {
        self.grabber = [[VBAddressBookGrabber alloc] init];
    }
    
    return self;
}

@end
