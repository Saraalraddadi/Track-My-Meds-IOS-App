//
//  MagicalRecord+Setup.h
//  Magical Record
//


#import <MagicalRecord/MagicalRecordInternal.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface MagicalRecord (Setup)

+ (void) setupCoreDataStack;
+ (void) setupCoreDataStackWithInMemoryStore;
+ (void) setupAutoMigratingCoreDataStack;

+ (void) setupCoreDataStackWithStoreNamed:(MR_nonnull NSString *)storeName;
+ (void) setupCoreDataStackWithAutoMigratingSqliteStoreNamed:(MR_nonnull NSString *)storeName;

+ (void) setupCoreDataStackWithStoreAtURL:(MR_nonnull NSURL *)storeURL;
+ (void) setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:(MR_nonnull NSURL *)storeURL;


@end
