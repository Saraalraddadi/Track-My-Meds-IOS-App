//
//  NSRelationshipDescription+MagicalDataImport.m
//  Magical Record
//
//

#import "NSRelationshipDescription+MagicalDataImport.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "MagicalImportFunctions.h"

@implementation NSRelationshipDescription (MagicalRecord_DataImport)

- (NSString *) MR_primaryKey;
{
    NSString *primaryKeyName = [[self userInfo] objectForKey:kMagicalRecordImportRelationshipLinkedByKey] ?: 
    MR_primaryKeyNameFromString([[self destinationEntity] name]);
    
    return primaryKeyName;
}

@end
