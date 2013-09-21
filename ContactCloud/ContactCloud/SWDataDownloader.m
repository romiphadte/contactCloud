////
////  SWDataDownloader.m
////  ContactCloud
////
////  Created by Siddhant Dange on 9/21/13.
////  Copyright (c) 2013 Romi Phadte. All rights reserved.
////
//
//#import "SWDataDownloader.h"
//#import "SWDataManager.h"
//
//#import <Parse/Parse.h>
//
//@implementation SWDataDownloader
//
//-(void)searchCloudForName:(NSString*)searchText withUICompletion:(void(^)(void))uiCompletionBlock{
//    PFQuery *fullNameQuery = [PFQuery queryWithClassName:@"People"];
//    [fullNameQuery whereKey:@"fullname" containsString:[searchText lowercaseString]];
//    
//    [fullNameQuery setLimit:50];
//    // * server waiting spinner on + appear
//    
//    [fullNameQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSMutableArray *processedResults = [NSMutableArray array];
//        for (int a = 0; a < [objects count]; a++)
//        {
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            NSDictionary *current = [objects objectAtIndex:a];
//            [dict setObject:[current objectForKey:@"firstname"] forKey:@"First"];
//            [dict setObject:[current objectForKey:@"lastname"] forKey:@"Last"];
//            NSString *fullName = [NSString stringWithFormat:@"%@ %@", [[current objectForKey:@"firstname"] capitalizedString], [[current objectForKey:@"lastname"] capitalizedString]];
//            [dict setObject:fullName forKey:@"FullName"];
//            [dict setObject:[current objectForKey:@"number"] forKey:@"Phone"];
//            [dict setObject:@"YES" forKey:@"isFromServer"];
//            
//            [processedResults addObject:dict];
//        }
//        
//        NSArray *allResults = [[SWDataManager sharedInstance] readContactsFromFile];
//        
//        
//        
//        NSMutableSet *intermediate = [NSMutableSet setWithArray:[SWDataManager load] allResults];
//        [intermediate addObjectsFromArray:processedResults];
//        _allResults = [[intermediate allObjects] mutableCopy];
//        
//        NSSortDescriptor *server = [[NSSortDescriptor alloc] initWithKey:@"isFromServer" ascending:YES];
//        NSSortDescriptor *fullName = [[NSSortDescriptor alloc] initWithKey:@"FullName" ascending:YES];
//        _allResults = [[_allResults sortedArrayUsingDescriptors:[NSArray arrayWithObjects:server, fullName, nil]] mutableCopy];
//        
//        [self.searchDisplayController.searchResultsTableView reloadData];
//    }];
//}
//@end
