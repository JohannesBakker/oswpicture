//
//  DBManager.m
//  ProximityBLE
//
//  Created by Admin on 2/10/15.
//  Copyright (c) 2015 RuiFeng. All rights reserved.
//

#import "DBManager.h"
#import "AppDelegate.h"
#import "OSWPictureDefine.h"

static DBManager* _sharedInstance;

@implementation DBManager

- (AppDelegate *)appDelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (DBManager*)sharedInstance {
    if (_sharedInstance == nil)
        _sharedInstance = [[DBManager alloc] init];
    
    return _sharedInstance;
}

- (NSMutableArray *)getAllNames {
    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kOSWPictureNameEntity inManagedObjectContext:[self appDelegate].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    NSError *error = nil;
    NSArray *fetchedObjects = [[self appDelegate].managedObjectContext executeFetchRequest:request error:&error];

    for (int i = 0; i < fetchedObjects.count; i++) {
        OSWPictureName *newName = (OSWPictureName *)[fetchedObjects objectAtIndex:i];
        [arrayEquipments addObject:newName];
    }

    return arrayEquipments;
}

- (BOOL)addName:(NSString *)newName {
    BOOL bRet = YES;
    if ([self isExistName:newName]) {
        bRet = NO;
    } else {
        OSWPictureName* addingName = [NSEntityDescription insertNewObjectForEntityForName:kOSWPictureNameEntity inManagedObjectContext:[self appDelegate].managedObjectContext];
            addingName.name = newName;
            NSError* error = nil;
            if (![[self appDelegate].managedObjectContext save:&error]) {
                bRet = NO;
            } else {
                bRet = YES;
            }
    }
    
    return bRet;
}

- (BOOL)deleteName:(NSString *)oldName {
    BOOL bRet = YES;
    if ([self isExistName:oldName] == NO) {
        bRet = NO;
    } else {
        OSWPictureName *existName = [self getExistName:oldName];
        if (existName == nil) {
            bRet = YES;
        } else {
            NSError* error = nil;
            [[self appDelegate].managedObjectContext deleteObject:existName];
            if (![[self appDelegate].managedObjectContext save:&error]) {
                bRet = NO;
            } else {
                bRet = YES;
            }
        }
    }
    
    return bRet;
}

- (BOOL)isExistName:(NSString *)name {
    NSMutableArray *arrayNames = [[NSMutableArray alloc] init];
    arrayNames = [self getAllNames];

    for (int i = 0; i < arrayNames.count; i++) {
        OSWPictureName *savedName = (OSWPictureName *) [arrayNames objectAtIndex:i];
        if ([savedName.name isEqualToString:name]) {
            return YES;
        }
    }

    return NO;
}
- (OSWPictureName *)getExistName:(NSString *)name {
    OSWPictureName *existName = nil;
    
    NSMutableArray *arrayNames = [[NSMutableArray alloc] init];
    arrayNames = [self getAllNames];
    
    for (int i = 0; i < arrayNames.count; i++) {
        OSWPictureName *savedName = (OSWPictureName *) [arrayNames objectAtIndex:i];
        if ([savedName.name isEqualToString:name]) {
            existName = savedName;
        }
    }
    
    return existName;
}

//
//- (BOOL) saveEquipment:(CBPeripheral *)peripheral {
//    BOOL isSaved = NO;
//    
//    if ([self getEquipmentWithUUID:[peripheral.identifier UUIDString]] == nil)
//    {
//        Equipment* newEquipment = [NSEntityDescription insertNewObjectForEntityForName:@"Equipment" inManagedObjectContext:[self appDelegate].managedObjectContext];
//        newEquipment.uuid = [peripheral.identifier UUIDString];
//        newEquipment.name = peripheral.name;
//        newEquipment.autoconnect = [NSNumber numberWithBool:NO];
//        newEquipment.autodisarm = [NSNumber numberWithBool:NO];
//        newEquipment.powersave = [NSNumber numberWithBool:NO];
//        newEquipment.favorites = [NSNumber numberWithBool:NO];
//        NSError* error = nil;
//        if (![[self appDelegate].managedObjectContext save:&error]) {
//            isSaved = NO;
//        } else {
//            isSaved = YES;
//        }
//    }
//    
//    return isSaved;
//}
//
//- (BOOL) updateEquipmentName:(NSString *) uuid name:(NSString *) name {
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Equipment"];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"uuid==%@", uuid]; // If required to fetch specific vehicle
//    fetchRequest.predicate=predicate;
//    Equipment *updateEquip = [[[self appDelegate].managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
//    
//    if (updateEquip != nil)
//    {
//        [updateEquip setValue:name forKey:@"name"];
//        [[self appDelegate].managedObjectContext save:nil];
//    }
//    return YES;
//}
//
//- (BOOL) updateFavoriteStatus:(NSString *) uuid status:(BOOL) status {
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Equipment"];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"uuid==%@", uuid]; // If required to fetch specific vehicle
//    fetchRequest.predicate=predicate;
//    Equipment *updateEquip = [[[self appDelegate].managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
//    
//    if (updateEquip != nil)
//    {
//        [updateEquip setValue:[NSNumber numberWithBool:status] forKey:@"favorites"];
//        //[[self appDelegate].managedObjectContext save:nil];
//        
//        NSError* error = nil;
//        if (![[self appDelegate].managedObjectContext save:&error]) {
//            return NO;
//        } else {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (NSMutableArray *) getAllEquipments {
//    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Equipment" inManagedObjectContext:[self appDelegate].managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entity];
//    
//    NSError *error = nil;
//    NSArray *fetchedObjects = [[self appDelegate].managedObjectContext executeFetchRequest:request error:&error];
//    
//    for (int i = 0; i < fetchedObjects.count; i++) {
//        Equipment *newEquip = (Equipment *)[fetchedObjects objectAtIndex:i];
//        [arrayEquipments addObject:newEquip];
//    }
//    
//    return arrayEquipments;
//}
//
//- (Equipment*) getEquipmentWithUUID:(NSString *)uuid {
//    Equipment *equip = nil;
//    
//    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
//    arrayEquipments = [self getAllEquipments];
//    
//    for (int i = 0; i < arrayEquipments.count; i++) {
//        Equipment *savedEquip = (Equipment *) [arrayEquipments objectAtIndex:i];
//        if ([savedEquip.uuid isEqualToString:uuid]) {
//            return savedEquip;
//        }
//    }
//    
//    return equip;
//}
//
//- (NSString*) getEquipNameWithUUID:(NSString *)uuid {
//    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
//    arrayEquipments = [self getAllEquipments];
//    
//    for (int i = 0; i < arrayEquipments.count; i++) {
//        Equipment *savedEquip = (Equipment *) [arrayEquipments objectAtIndex:i];
//        if ([savedEquip.uuid isEqualToString:uuid]) {
//            return savedEquip.name;
//        }
//    }
//    
//    return @"No Name";    
//}
//
//- (BOOL) getEquipFavoriteStatusWithUUID:(NSString *)uuid {
//    Equipment *equip = nil;
//    
//    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
//    arrayEquipments = [self getAllEquipments];
//    
//    for (int i = 0; i < arrayEquipments.count; i++) {
//        Equipment *savedEquip = (Equipment *) [arrayEquipments objectAtIndex:i];
//        if ([savedEquip.uuid isEqualToString:uuid]) {
//            return [savedEquip.favorites boolValue];
//            break;
//        }
//    }
//    return NO;
//}
//
//- (BOOL) isSavedEquipment:(NSString *) uuid {
//    BOOL isSaved = NO;
//    
//    NSMutableArray *arrayEquipments = [[NSMutableArray alloc] init];
//    arrayEquipments = [self getAllEquipments];
//    
//    for (int i = 0; i < arrayEquipments.count; i++) {
//        Equipment *savedEquip = (Equipment *) [arrayEquipments objectAtIndex:i];
//        if ([savedEquip.uuid isEqualToString:uuid]) {
//            isSaved = YES;
//            break;
//        }
//    }
//    
//    return isSaved;
//}

@end
