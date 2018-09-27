//
//  Api.m
//  Vanthink_tea
//
//  Created by 王成浩 on 2018/6/9.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import "Api.h"
#import "AppDelegate.h"

typedef void(^successCallback)(NSURLSessionDataTask *, id);
typedef void(^failureCallback)(NSURLSessionDataTask *, NSError *);

@implementation Api

+ (instancetype)sharedClient {
    static Api *_api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[Api alloc]initWithBaseURL:[NSURL URLWithString:@""]];
        //最大请求并发任务数
        _api.operationQueue.maxConcurrentOperationCount = 5;
        _api.requestSerializer.timeoutInterval = 15.f;
    });
    return _api;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    __weak __typeof(self) weakSelf = self;
    return [super GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask *task, id response){
        NSLog(@"GET success \nurl=%@,\nparams=%@,\nresponse=%@", URLString, parameters, response);
        __strong __typeof(weakSelf) sSelf = weakSelf;
        [sSelf handleTask:task response:response withSuccess:success withFail:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"GET failure \nurl=%@,\nparams=%@,\nerror=%@",URLString, parameters, error);
        __strong __typeof(weakSelf) sSelf = weakSelf;
        [sSelf handleTask:task error:error withFail:failure];
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    __weak __typeof(self) weakSelf = self;
    return [super POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask *task, id response) {
        __strong __typeof(weakSelf) sSelf = weakSelf;
        NSLog(@"POST success \nurl=%@,\nparams=%@,\nresponse=%@",URLString, parameters, response);
        [sSelf handleTask:task response:response withSuccess:success withFail:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"POST failure \nurl=%@,\nparams=%@,\nerror=%@",URLString, parameters, error);
        __strong __typeof(weakSelf) sSelf = weakSelf;
        [sSelf handleTask:task error:error withFail:failure];
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    __weak __typeof(self) weakSelf = self;
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask *task, id response) {
        __strong __typeof(weakSelf) sSelf = weakSelf;
        NSLog(@"POST success \nurl=%@,\nparams=%@,\nresponse=%@",URLString, parameters, response);
        [sSelf handleTask:task response:response withSuccess:success withFail:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"POST failure \nurl=%@,\nparams=%@,\nerror=%@",URLString, parameters, error);
        __strong __typeof(weakSelf) sSelf = weakSelf;
        [sSelf handleTask:task error:error withFail:failure];
    }];
}

- (void)handleTask:(NSURLSessionDataTask *)task response:(id)response withSuccess:(successCallback)success withFail:(failureCallback)failure {
    [self hideHUD];
    success(task, response);
}

- (void)handleTask:(NSURLSessionDataTask *)task error:(NSError *)error withFail:(failureCallback)failure {
    [self hideHUD];
    if (failure) {
        failure(task, error);
    }
}

@end




