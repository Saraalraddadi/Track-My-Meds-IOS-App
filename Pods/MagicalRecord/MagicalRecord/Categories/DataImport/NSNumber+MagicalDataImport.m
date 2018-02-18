//
//  NSNumber+MagicalDataImport.m
//  Magical Record
//


#import "NSNumber+MagicalDataImport.h"

@implementation NSNumber (MagicalRecord_DataImport)

- (NSString *)MR_lookupKeyForAttribute:(NSAttributeDescription *)attributeInfo
{
    return nil;
}

- (id)MR_relatedValueForRelationship:(NSRelationshipDescription *)relationshipInfo
{
    return self;
}

@end
