//
//  QlNetworkHelper.m
//  TYBProject
//
//  Created by 钱龙 on 16/11/18.
//  Copyright © 2016年 钱龙. All rights reserved.
//

#import "QlNetworkHelper.h"
#import "AFNetworking.h"

@interface QlNetworkHelper()
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@property (nonatomic,strong)NSString * netStatus;

@end
@implementation QlNetworkHelper
+(instancetype)sharedManager{
    static QlNetworkHelper * networkHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkHelper = [[self alloc]init];
    });
    return networkHelper;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        self.netStatus = [NSString string];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return self;
}
-(void)networkReaching{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *mNetworkStatus = [NSString string];
        switch (status) {
            case -1:
                mNetworkStatus = @"Unknown";
                break;
            case 0:
                mNetworkStatus = @"NotReachable";
                break;
            case 1:
                mNetworkStatus = @"WWAN";
                break;
            case 2:
                mNetworkStatus = @"WiFi";
                break;
            default:
                break;
        }
        if (self.netStatus) {
            if (![self.netStatus isEqualToString:mNetworkStatus]) {//网络状态发生变化，拋一个通知出来
                self.netStatus = mNetworkStatus;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NetReachabilityStatusChanged" object:nil userInfo:@{@"networkStatus":mNetworkStatus}];
            }
        }else{
            
            self.netStatus = mNetworkStatus;
        }
        
        DLog(@"当前网络状态 = %@",self.netStatus);
    }];
}
-(void)getWithURL:(NSString *)urlString WithParameters:(NSDictionary *)parameter compeletionWithBlock:(QlNetworkHelperBlock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.manager GET:url.absoluteString parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //        id retArr = (NSArray *)responseObject;
        BLOCK_EXEC(block,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(block,error);
        DLog(@"error:%@", error.description);
    }];
    /*
     [self.manger GET:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
     
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     //        id retArr = (NSArray *)responseObject;
     BLOCK_EXEC(block,responseObject);
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     DLog(@"error:%@", error.description);
     }];
     */
    
}

-(void)postWithURL:(NSString *)urlString WithParameters:(NSDictionary *)parameter compeletionWithBlock:(QlNetworkHelperBlock)block{
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self.manager POST:url.absoluteString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        DLog(@"%@",url);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        BLOCK_EXEC(block,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(block,error);
        DLog(@"error:%@", error.description);
        
    }];
    /*
     [self.manger POST:url.absoluteString parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
     
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSDictionary *dic = (NSDictionary *)responseObject;
     BLOCK_EXEC(block,dic);
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     DLog(@"error:%@", error.description);
     }];
     */
}













@end
