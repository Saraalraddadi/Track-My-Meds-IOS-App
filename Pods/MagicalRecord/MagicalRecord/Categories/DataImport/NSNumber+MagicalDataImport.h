//
//  NSNumber+MagicalDataImport.h
//  Magical Record
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSNumber (MagicalRecord_DataImport)

- (MR_nullable NSString *)MR_lookupKeyForAttribute:(MR_nonnull NSAttributeDescription *)attributeInfo;
- (MR_nonnull id)MR_relatedValueForRelationship:(MR_nonnull NSRelationshipDescription *)relationshipInfo;

@end
