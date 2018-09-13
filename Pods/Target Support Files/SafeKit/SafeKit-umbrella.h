#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SafeKit.h"
#import "Foundation+SafeKit.h"
#import "NSArray+SafeKit.h"
#import "NSDictionary+SafeKit.h"
#import "NSMutableArray+SafeKit.h"
#import "NSMutableDictionary+SafeKit.h"
#import "NSMutableString+SafeKit.h"
#import "NSNumber+SafeKit.h"
#import "NSString+SafeKit.h"
#import "NSMutableArray+SafeKitMRC.h"
#import "NSObject+Swizzle.h"
#import "SafeKitCore.h"
#import "SafeKitMacro.h"

FOUNDATION_EXPORT double SafeKitVersionNumber;
FOUNDATION_EXPORT const unsigned char SafeKitVersionString[];

