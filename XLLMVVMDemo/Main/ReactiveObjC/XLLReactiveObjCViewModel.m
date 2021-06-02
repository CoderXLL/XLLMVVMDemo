//
//  XLLReactiveObjCViewModel.m
//  XLLMVVMDemo
//
//  Created by xiaoll on 2021/6/2.
//

#import "XLLReactiveObjCViewModel.h"

@interface XLLReactiveObjCViewModel()

@end

@implementation XLLReactiveObjCViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.clearCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            self.password = @"";
            return [RACSignal empty];
        }];
    }
    return self;
}

@end
