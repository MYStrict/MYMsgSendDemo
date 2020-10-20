//
//  Father.m
//  MYMsgSendDemo
//
//  Created by yan ma on 2020/10/20.
//  Copyright © 2020 MYStrict. All rights reserved.
//

#import "Father.h"

#import "Son.h"
#import <objc/runtime.h>

@implementation Father

#pragma mark - 动态方法解析
//动态方法解析
//void playBasketBall() {
//    NSLog(@"father: play the basketball");
//}
//
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSString *method = NSStringFromSelector(sel);
//    if ([@"playTheGuitar" isEqualToString:method]) {
//        /**
//         添加方法
//         参数1 （Class cls）  :  self -  调用该方法的对象
//         参数2 （SEL name）：sel 将要添加的方法名，
//         参数3  （IMP imp）  : IMP  - 实现这个方法的函数，
//         1，c语言写法：(IMP)方法名； 2，OC的写法：class_getMethodImplementation(self,@selector(方法名：))
//         参数4（const char *types）: 新添加的方法的类型，包含函数的返回值以及参数内容类型
//         eg : "v@:@": v: 是添加方法无返回值  @表示是id(也就是要添加的类)：表示添加的方法类型
//         @表示：参数类型
//         ""
//
//         */
//        class_addMethod(self, sel, (IMP)playBasketBall, "v");
//        return YES;
//    }
//    return NO;
//}

//注意：用这个方法添加的方法是无法直接调用的，必须用performSelector：调用。
//以为performSelector:是运行时系统负责去找方法的，在编译时候不做任何校验；如果直接调用编译是会自动校验。
//你添加方法是在运行时添加的，你在编译的时候还没有这个本类方法，所以当然不行。


#pragma mark - 备用接受者

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *selectorStr = NSStringFromSelector(aSelector);
//    if ([@"playTheGuitar" isEqualToString:selectorStr]) {
//        Son *ss = [[Son alloc] init];
//        return ss;
//    }
//    
//    //继续转发
//    return [super forwardingTargetForSelector:aSelector];
//}

#pragma mark - 完整消息转发

- (void)makeGirlFriend: (NSString *)name {
    NSLog(@"Father: make a girlFriend = %@",name);
}

//获取消息签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *method = NSStringFromSelector(aSelector);
    if ([@"playTheGuitar" isEqualToString:method]) {
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return signature;
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = @selector(makeGirlFriend:);
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    anInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [anInvocation setTarget:self];
    [anInvocation setSelector:@selector(makeGirlFriend:)];
    NSString *name = @"小芳";
    [anInvocation setArgument:&name atIndex:2];
    
    if ([self respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self];
        return;
    }else {
        Son *ss = [[Son alloc] init];
        if ([ss respondsToSelector:sel]) {
            [anInvocation invokeWithTarget:ss];
            return;
        }
        
    }
    
    //
    [super forwardInvocation:anInvocation];
    
}


@end
