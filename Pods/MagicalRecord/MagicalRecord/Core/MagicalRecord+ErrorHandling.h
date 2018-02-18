//
//  MagicalRecord+ErrorHandling.h
//  Magical Record
//


#import <MagicalRecord/MagicalRecordInternal.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface MagicalRecord (ErrorHandling)

+ (void) handleErrors:(MR_nonnull NSError *)error;
- (void) handleErrors:(MR_nonnull NSError *)error;

+ (void) setErrorHandlerTarget:(MR_nullable id)target action:(MR_nonnull SEL)action;
+ (MR_nonnull SEL) errorHandlerAction;
+ (MR_nullable id) errorHandlerTarget;

@end
