//
//  XLLReactiveObjCViewModel.h
//  XLLMVVMDemo
//
//  Created by xiaoll on 2021/6/2.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLLReactiveObjCViewModel : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) RACCommand *clearCommand;

@end

NS_ASSUME_NONNULL_END
