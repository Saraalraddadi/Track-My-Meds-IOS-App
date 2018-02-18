//
//  NSManagedObjectContext+MagicalThreading.h
//  Magical Record
//
//

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSManagedObjectContext (MagicalThreading)

+ (MR_nonnull NSManagedObjectContext *) MR_contextForCurrentThread __attribute((deprecated("This method will be removed in MagicalRecord 3.0")));
+ (void) MR_clearNonMainThreadContextsCache __attribute((deprecated("This method will be removed in MagicalRecord 3.0")));
+ (void) MR_resetContextForCurrentThread __attribute((deprecated("This method will be removed in MagicalRecord 3.0")));
+ (void) MR_clearContextForCurrentThread __attribute((deprecated("This method will be removed in MagicalRecord 3.0")));

@end
