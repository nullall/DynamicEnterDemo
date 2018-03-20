//
//  LCHttpRequest.h
//  MyTools
//
//  Created by Leon on 11/25/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XIIHttpRequest : NSObject


/**
 单例模式
 
 @return 本身
 */
+ (instancetype)sharedInstance;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param show    是否显示hud
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param show    是否显示hud
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)getWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  取消请求
 */
- (void)cancelRequestTask;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray showHud:(BOOL)show success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

//post完整的接口
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     完整的请求路径
 *  @param params  请求参数
 *  @param formDataArray  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)postWithFullURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params showHud:(BOOL)show success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end


/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;


@end
