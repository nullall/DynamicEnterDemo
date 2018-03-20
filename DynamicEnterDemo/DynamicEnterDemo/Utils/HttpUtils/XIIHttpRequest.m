//
//  XIIHttpRequest.m
//  MyTools
//
//  Created by Leon on 11/25/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import "XIIHttpRequest.h"
#import "AFNetworking.h"
//#import <AFNetworking.h>
#import "AppDelegate.h"

@interface XIIHttpRequest()
/** 网络会话管理者 */
@property(strong,nonatomic) AFHTTPSessionManager *mgr;
@end

@implementation XIIHttpRequest

static id _instansce;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instansce = [super allocWithZone:zone];
    });
    return _instansce;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instansce = [[self alloc] init];
    });
    return _instansce;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instansce;
}

- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [self.mgr POST:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    [self.mgr POST:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];
}



- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self.mgr GET:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    [self.mgr GET:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];
}

- (void)cancelRequestTask
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}



+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //     1.创建请求管理对象
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    //调正失败响应时间
    //    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    mgr.requestSerializer.timeoutInterval = 30.f;
    //    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //     2.发送请求
    [mgr POST:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //    [mgr POST:[self getUrl:url] parameters:params
    //      success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //          if (success) {
    //              [self printObject:responseObject];
    //              success(responseObject);
    //          }
    //      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //          if (failure) {
    //              failure(error);
    //          }
    //      }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //     2.发送请求
    [mgr POST:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:[self getUrl:url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        NSLog(@"xijijo");
        for (FormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //    [mgr POST:[self getUrl:url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
    //        for (FormData *formData in formDataArray) {
    //            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
    //        }
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        if (success) {
    ////            [self printObject:responseObject];
    //            success(responseObject);
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:[self getUrl:url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        NSLog(@"xijijo");
        for (FormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];
    
}


//post完整的接口
+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 1.创建请求管理对象
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //    //调正失败响应时间
    //    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    mgr.requestSerializer.timeoutInterval = 30.f;
    //    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 2.发送请求
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    //    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        if (success) {
    //            [self printObject:responseObject];
    //            success(responseObject);
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];
}

+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.发送请求
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        NSLog(@"xijijo");
        for (FormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    //    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
    //        for (FormData *formData in formDataArray) {
    //            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
    //        }
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        if (success) {
    //            //            [self printObject:responseObject];
    //            success(responseObject);
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.创建请求管理对象
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    /**
     * 此处比较特殊，某个请求返回的类型是text/plain，afnet默认属性不包含，如果直接使用会报错，需要将请求返回数据类型设置成NSData。
     */
    mgr.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    
    //调正失败响应时间
    //    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    mgr.requestSerializer.timeoutInterval = 40.f;
    //    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //    if(![url isEqualToString:LoginAddress])
    //    {
    //        NSUserDefaults* myDef=[NSUserDefaults standardUserDefaults];
    //        NSString* cookie=[myDef objectForKey:@"session"];
    //        cookie=[NSString stringWithFormat:@"JSESSIONID=%@;",cookie];
    //        [mgr.requestSerializer setValue:cookie forHTTPHeaderField:@"cookie"];
    //    }
    // 2.发送请求
    [mgr GET:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    //    [mgr GET:[self getUrl:url] parameters:params
    //     success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //         if (success) {
    //             [self printObject:responseObject];
    //             success(responseObject);
    //         }
    //     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //         if (failure) {
    //             failure(error);
    //         }
    //     }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    if (show == YES) {
        UIView *view = [UIApplication sharedApplication].keyWindow;
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    /**
     * 此处比较特殊，下载文件请求返回的类型是text/plain，afnet默认属性不包含，如果直接使用会报错，需要将请求返回数据类型设置成NSData。
     */
    mgr.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    // 2.发送请求
    [mgr GET:[self getUrl:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        if (success) {
            //            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)printObject:(NSData *)responseObject{
    if ([NSJSONSerialization isValidJSONObject:responseObject]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"response --> \n%@",json);
    }
    else
    {
        
        //        NSLog(@"response --> \n%@",responseObject);
    }
}


+ (NSString *)getUrl:(NSString *)url {
//    AppDelegate* sysDelegate;
//    sysDelegate=appDelegate;
//    NSLog(@"%@",[NSString stringWithFormat:@"%@/%@",sysDelegate.serverAddr,url]);
    
//    return [NSString stringWithFormat:@"%@/%@",sysDelegate.serverAddr,url];
    
    return url;
}

- (NSString *)getUrl:(NSString *)url {
//    AppDelegate* sysDelegate;
//    sysDelegate=appDelegate;
//    NSLog(@"%@",[NSString stringWithFormat:@"%@/%@",sysDelegate.serverAddr,url]);
//
//    return [NSString stringWithFormat:@"%@/%@",sysDelegate.serverAddr,url];
    return url;
}



@end

@implementation FormData

@end


