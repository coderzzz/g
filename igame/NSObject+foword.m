//
//  NSObject+foword.m
//  igame
//
//  Created by Interest on 2017/2/7.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import "NSObject+foword.h"

@implementation NSObject (foword)
//+(void)load{
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(forwardingTargetForSelector:);
//        SEL swizzledSelector = @selector(zz_forwardingTargetForSelector:);
//        
//        Method originalMethod = class_getClassMethod(class, originalSelector);
//        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
//        
//        BOOL didaddmethod = class_addMethod(class, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        
//    });
//}
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    
//
//    
//       return nil;
//}
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
    NSLog(@"doesNotRecognizeSelector = %@",NSStringFromSelector(aSelector));
}


-(id)zz_forwardingTargetForSelector:(SEL)aSelector{
    
    
    NSString *selectorstr = NSStringFromSelector(aSelector);
    NSLog(@"selectorstr = %@",selectorstr);
    return [self zz_forwardingTargetForSelector:aSelector];
}
@end
