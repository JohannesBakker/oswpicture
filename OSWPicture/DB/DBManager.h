//
//  DBManager.h
//  ProximityBLE
//
//  Created by Admin on 2/10/15.
//  Copyright (c) 2015 RuiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSWPictureName.h"
#import "OSWPictureImgList.h"

@interface DBManager : NSObject {
}

+ (DBManager*)sharedInstance;

- (NSMutableArray *)getAllNames;
- (BOOL)addName:(NSString *)newName;
- (BOOL)deleteName:(NSString *)oldName;
- (BOOL)isExistName:(NSString *)name;
- (OSWPictureName *)getExistName:(NSString *)name;

@end
