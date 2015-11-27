//
//  NSString+Helper.h
//  StringHelper
//
//  Created by 郭锐 on 15/11/27.
//  Copyright © 2015年 Garrry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringMaker : NSObject
-(StringMaker *(^)(NSString *))append;
-(StringMaker *(^)(NSString *, NSString *))replace;
-(StringMaker *(^)(NSString *))remove;
@end

@interface NSString (Helper)
@property(nonatomic,strong)StringMaker *stringMaker;
+(NSString *)makeString:(void (^)(StringMaker *make))string;
@end
