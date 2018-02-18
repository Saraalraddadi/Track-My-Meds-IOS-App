//
//  NSDictionary+MagicalDataImport.h
//  Magical Record
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSObject (MagicalRecord_DataImport)

- (MR_nullable NSString *) MR_lookupKeyForAttribute:(MR_nonnull NSAttributeDescription *)attributeInfo;
- (MR_nullable id) MR_valueForAttribute:(MR_nonnull NSAttributeDescription *)attributeInfo;

- (MR_nullable NSString *) MR_lookupKeyForRelationship:(MR_nonnull NSRelationshipDescription *)relationshipInfo;
- (MR_nullable id) MR_relatedValueForRelationship:(MR_nonnull NSRelationshipDescription *)relationshipInfo;

@end
