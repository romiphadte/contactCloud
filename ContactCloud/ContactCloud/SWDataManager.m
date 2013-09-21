//
//  SWDataManager.m
//  ContactCloud
//
//  Created by Siddhant Dange on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWDataManager.h"
#import "SWDataUploader.h"

@interface SWDataManager ()

@property (nonatomic, strong) SWDataUploader *uploader;

@end

static SWDataManager *gInstance;
@implementation SWDataManager

#pragma -mark Uploader Methods

-(void)handleStartUpload{
    
    //if first time using app, then load contacts to db
    if(![[NSFileManager defaultManager] fileExistsAtPath:[SWDataManager filepath:@"contacts"]]){
        [self.uploader uploadAddressBookWithCompletion:^(NSError *error, NSArray *addressBook) {
            if(!error){
                NSLog(@"success loading to db");
                self.contactsList = addressBook.copy;
                [self writeContactsToFile];
            } else{
                NSLog(@"error loading to db: %@", error);
            }
        }];
    } else{ //else load from file first
        self.contactsList = [self readContactsFromFile].mutableCopy;
    }
}

#pragma -mark Downloader Methods

#pragma -mark General Methods

-(BOOL)writeContactsToFile{
    return [NSKeyedArchiver archiveRootObject:self.contactsList toFile:[SWDataManager filepath:@"contacts"]];
}

-(NSArray*)readContactsFromFile{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[SWDataManager filepath:@"contacts"]];
}

+(NSString*)filepath:(NSString*)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [paths objectAtIndex:0];
    return [filepath stringByAppendingFormat:@"/%@.plist",file];
}

#pragma -mark Singleton Methods

+(SWDataManager *)setupInstance{
    if(!gInstance){
        gInstance = [[SWDataManager alloc] init];
        
        gInstance.uploader = [[SWDataUploader alloc] init];
    }
    
    return gInstance;
}

+(SWDataManager *)sharedInstance{
    return gInstance;
}

@end
