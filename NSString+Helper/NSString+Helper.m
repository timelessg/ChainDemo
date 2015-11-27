//
//  NSString+Helper.m
//  StringHelper
//
//  Created by 郭锐 on 15/11/27.
//  Copyright © 2015年 Garrry. All rights reserved.
//

#import "NSString+Helper.h"
#import <objc/runtime.h>

const char kStringMaker;

@interface StringMaker ()
@property(nonatomic,strong)NSMutableString *mutableString;
@end

@implementation StringMaker
-(StringMaker *(^)(NSString *))append{
    return ^id(NSString *string){
        [self.mutableString appendString:string];
        return self;
    };
}
-(StringMaker *(^)(NSString *))remove{
    return ^id(NSString *string){
        [self.mutableString replaceOccurrencesOfString:string withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [self.mutableString length])];
        return self;
    };
}
-(StringMaker *(^)(NSString *, NSString *))replace{
    return ^id(NSString *orgString,NSString *repString){
        [self.mutableString replaceOccurrencesOfString:orgString withString:repString options:NSLiteralSearch range:NSMakeRange(0, [self.mutableString length])];
        return self;
    };
}
-(NSMutableString *)mutableString{
    if (!_mutableString) {
        _mutableString = [NSMutableString string];
    }
    return _mutableString;
}
@end

@implementation NSString (Helper)
+(NSString *)makeString:(void (^)(StringMaker *))string{
    StringMaker *stringMaker = [StringMaker new];
    string(stringMaker);
    return [stringMaker.mutableString copy];
}
-(void)setStringMaker:(StringMaker *)stringMaker{
    objc_setAssociatedObject(self, &kStringMaker, stringMaker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(StringMaker *)stringMaker{
    return objc_getAssociatedObject(self, &kStringMaker);
}
@end

