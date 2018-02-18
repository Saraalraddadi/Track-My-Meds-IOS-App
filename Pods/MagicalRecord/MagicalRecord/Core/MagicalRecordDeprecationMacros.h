
#define MR_DEPRECATED_WILL_BE_REMOVED_IN(VERSION) __attribute__((deprecated("This method has been deprecated and will be removed in MagicalRecord " VERSION ".")))
#define MR_DEPRECATED_WILL_BE_REMOVED_IN_PLEASE_USE(VERSION, METHOD) __attribute__((deprecated("This method has been deprecated and will be removed in MagicalRecord " VERSION ". Please use `" METHOD "` instead.")))
