//
//  SWDataManager.h
//  ContactCloud
//
//  Created by Siddhant Dange on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *contactsList;

#pragma -mark Uploader Methods
-(void)handleStartUpload;

#pragma -mark Downloader Methods

#pragma -mark General Methods
-(BOOL)writeContactsToFile;
-(NSArray*)readContactsFromFile;

+(NSString*)filepath:(NSString*)file;


#pragma -mark Singleton Methods
+(SWDataManager*)setupInstance;
+(SWDataManager*)sharedInstance;

@end
