//
//  NSManagedObjectModel+MagicalRecord.h
//
//

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSManagedObjectModel (MagicalRecord)

+ (MR_nullable NSManagedObjectModel *) MR_defaultManagedObjectModel;

+ (void) MR_setDefaultManagedObjectModel:(MR_nullable NSManagedObjectModel *)newDefaultModel;

+ (MR_nullable NSManagedObjectModel *) MR_mergedObjectModelFromMainBundle;
+ (MR_nullable NSManagedObjectModel *) MR_newManagedObjectModelNamed:(MR_nonnull NSString *)modelFileName NS_RETURNS_RETAINED;
+ (MR_nullable NSManagedObjectModel *) MR_managedObjectModelNamed:(MR_nonnull NSString *)modelFileName;
+ (MR_nullable NSManagedObjectModel *) MR_newModelNamed:(MR_nonnull NSString *) modelName inBundleNamed:(MR_nonnull NSString *) bundleName NS_RETURNS_RETAINED;
+ (MR_nullable NSManagedObjectModel *) MR_newModelNamed:(MR_nonnull NSString *) modelName inBundle:(MR_nonnull NSBundle*) bundle NS_RETURNS_RETAINED;

@end
