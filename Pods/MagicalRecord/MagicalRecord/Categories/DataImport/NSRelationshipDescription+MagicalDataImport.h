//
//  NSRelationshipDescription+MagicalDataImport.h
//  Magical Record
//
//

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSRelationshipDescription (MagicalRecord_DataImport)

- (MR_nonnull NSString *) MR_primaryKey;

@end
