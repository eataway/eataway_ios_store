//
//  ObjectForRequest.m
//  EatAway
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ObjectForRequest.h"

#import <AFNetworking.h>


static ObjectForRequest * mainObj;

@implementation ObjectForRequest



+(ObjectForRequest *)shareObject
{
    if (!mainObj)
    {
        mainObj = [[ObjectForRequest alloc]init];
    }
    return mainObj;
}

-(void)requestWithURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager POST:[NSString stringWithFormat:@"%@/%@",HTTPHOST,strURL] parameters:dicPara progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
}
-(void)requestUploadImagesWithURL:(NSString *)strURL arrImages:(NSArray *)arrImages arrImageNames:(NSArray *)arrImageNames parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",HTTPHOST,strURL] parameters:dicPara constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int a = 0; a < arrImages.count; a ++)
        {
            UIImage *image = arrImages[a];
            NSData *dataImage = UIImageJPEGRepresentation(image, 0.5);
            
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyyMMddhhmmss"];
            NSString *strDateName = [formatter stringFromDate:date];
            NSString *strFileName = [NSString stringWithFormat:@"%@%d.jpg",strDateName,a];
            
            [formData appendPartWithFileData:dataImage name:arrImageNames[a] fileName:strFileName mimeType:@"image/jpeg"];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
    
    
}
-(void)requestPostWithFullURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager POST:[NSString stringWithFormat:@"%@",strURL] parameters:dicPara progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
}
-(void)requestGetWithFullURL:(NSString *)strURL resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager GET:[NSString stringWithFormat:@"%@",strURL] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
}
@end
