//
//  OSWPictureImgList.h
//  OSWPicture
//
//  Created by Admin on 6/23/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OSWPictureImgList : NSManagedObject

@property (nonatomic, retain) NSNumber * nId;
@property (nonatomic, retain) NSString * imgPath;

@end
