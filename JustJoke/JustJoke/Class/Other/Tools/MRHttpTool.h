


#import <AFNetworking.h>

@interface MRHttpTool :AFHTTPSessionManager

/**
 * 单例
 **/
+(MRHttpTool*)shareHttpTool;

/**
 *  发送一个POST请求
 */
- (void)postWithURLString:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 */
- (void)postWithURLString:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  发送一个GET请求
 */
- (void)getWithURLString:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end


/**
 *  用来封装文件数据的模型
 */
@interface MRFormData : NSObject
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