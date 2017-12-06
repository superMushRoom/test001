//
//  ViewController.m
//  Testwz
//
//  Created by 张文泽 on 2017/11/15.
//  Copyright © 2017年 wz. All rights reserved.
//

#import "ViewController.h"
#import <COSClient.h>
#import "InfoHeader.h"
#import <CocoaSecurity.h>
#import "Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import <AFNetworking.h>


@interface ViewController ()
{
    COSClient *myClient;
}
@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //    NSString *str = [self hmacSha1:@"4tU3QZUEi8PSGtMZWDpHTQCj4IK8j6DA" text:@"a=1255452243&b=test02io&k=AKID60e2B8oGRL2Vkla7SaVCfvxlLhql77Td&e=1511576428&t=1510712428&r=33556&f="];
    //
    //    NSLog(@"%@",str);
    //    NSString *originStr = [str stringByAppendingString:@"a=1255452243&b=test02io&k=AKID60e2B8oGRL2Vkla7SaVCfvxlLhql77Td&e=1511576428&t=1510712428&r=33556&f="];
    //    NSLog(@"%@",originStr);
    //
    //    NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
    //
    //    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //
    //    NSLog(@"encodeResult:%@",encodeResult);
    //
    //
    //    NSString *newSign = [self getSignWithSha1AndBase64:@"4tU3QZUEi8PSGtMZWDpHTQCj4IK8j6DA" andString:@"a=1255452243&b=test1&k=AKID60e2B8oGRL2Vkla7SaVCfvxlLhql77Td&e=1511576428&t=1510712428&r=33556&u=0&f="];
    
    
    //    NSString * encodeResult = @"QPVzllkOmmsx0SZDVALKEFTKh51hPTEyNTIwNzA4NDMmaz1BS0lEaExwRVhocGNRNGF6REp0eWExT2JlV1VJMFh1NkYxb1EmZT0wJnQ9MTUxMDczNzkxMSZyPTQ1MzEyMjE5MCZmPS8xMjUyMDcwODQzL2NvczEveHhzYW1wbGVfZm9sZGVyLyZiPWNvczE=";
    
    
    //    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
    //
    //    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    
    
    
    //    [self startUseCos:encodeResult];
    //    [self yuming];
    //    [self aftestwz:@"VtspiPesXQyXpmPza/cy/1wpVnZhPTEyNTIwNzA4NDMmaz0iQUtJRGhMcEVYaHBjUTRhekRKdHlhMU9iZVdVSTBYdTZGMW9RIiZlPTAmdD0xNTEwODIxMjgzJnI9MjA4NjE2MDM4MCZmPS8xMjUyMDcwODQzL3Rlc3QwMDEmYj10ZXN0MDAx"];
    
//    [self ff];
//    [self fffff];
    [self httpsTest];
    
}


- (void)btnAction{
    
    NSString*urlString=@"https://192.168.30.91/";
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy = [AFSecurityPolicy defaultPolicy];

    
    //是否允许,NO--不允许无效的证书...
    
    //因为大多数都是自己给自己颁布的证书,对于苹果来说是不被信任的,是无效的,所以要设置YES.
    
    securityPolicy.allowInvalidCertificates=YES;
    
    //设置证书如果不设置,可以自动读取工程里的cer文件
    
    // 1.zhengshu.cer ca.cer(一个是服务器证书,一个服务器CA根证书,哪一个都可以)
    
    //service.cer 2.服务器证书
    
    //securityPolicy.pinnedCertificates=set;
    
    //validatesDomainName是否需要验证域名，默认为YES；
    
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    
    //置为NO，主要用于这种情况:客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    
    //如置为NO，建议自己添加对应域名的校验逻辑。
    
    //一.zhengshu.cerhttps://192.168.30.91/无需设置infoplist
    
    //二.service.cerhttps://192.168.30.55:8443/IEMS_APP///模拟器必须设置info.plist YES真机不用设置info.plist
    
    //两种都可以加密数据安全,防止中间人抓包工具
    
    securityPolicy.validatesDomainName=NO;
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",nil];
    
    manager.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    
    __weak typeof(self)weakSelf =self;
    
    //重写这个方法就能提供客户端验证
    
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession*_Nonnullsession,NSError*_Nonnullerror) {
        
        NSLog(@"setSessionDidBecomeInvalidBlock");
        
    }];
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session,NSURLAuthenticationChallenge*challenge,NSURLCredential*__autoreleasing*_credential) {
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        
        __autoreleasing NSURLCredential *credential =nil;
        
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            
            if([manager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                
                if(credential) {
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                }else{
                    
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    
                }
                
            }else{
                
                disposition =NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                
            }
            
        }else{
            
            // client authentication
            
            SecIdentityRef identity =NULL;
            
            SecTrustRef trust =NULL;
            
            NSString*p12 = [[NSBundle mainBundle]pathForResource:@"client.key"ofType:@"p12"];
            
            NSFileManager*fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
                
            {
                
                NSLog(@"client.p12:not exist");
                
            }
            
            else
                
            {
                
                NSData*PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if([[weakSelf class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    
                {
                    
                    SecCertificateRef certificate =NULL;
                    
                    SecIdentityCopyCertificate(identity, &certificate);
                    
                    const void *certs[] = {certificate};
                    
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                }
                
            }
            
        }
        
        *_credential = credential;
        
        return disposition;
        
    }];
    
    manager.securityPolicy= securityPolicy;
    
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress*_Nonnull downloadProgress) {
        
    }success:^(NSURLSessionDataTask*_Nonnull task,id _Nullable responseObject) {
        
        NSString *html=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        self.label.text=html;
        
    }failure:^(NSURLSessionDataTask*_Nullabletask,NSError*_Nonnullerror) {
        
//        self.label.textColor=[UIColorredColor];
        
//        self.label.text=error.debugDescription;
        
    }];
    
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData*)inPKCS12Data {
    
    OSStatus securityError =errSecSuccess;
    
    //client certificate password
    
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"123456"
                                      
                                                                forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items =CFArrayCreate(NULL,0,0,NULL);
    
    securityError =SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError ==0) {
        
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        
        const void*tempIdentity =NULL;
        
        tempIdentity=CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemIdentity);
        
        *outIdentity = (SecIdentityRef)tempIdentity;
        
        const void*tempTrust =NULL;
        
        tempTrust =CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        
        *outTrust = (SecTrustRef)tempTrust;
        
    }else{
        
        NSLog(@"Failedwith error code %d",(int)securityError);
        
        return NO;
        
    }
    
    return YES;
    
}


// https ssl 验证接口
- (void)httpsTest{
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.加上这个函数，https ssl 验证。
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    // 设置请求接口回来的时候支持什么类型的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"https://127.0.0.1" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载的进度");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功:");
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"---------%@",str);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
        
    }];
    
    
}

// https ssl 验证函数

- (AFSecurityPolicy *)customSecurityPolicy {
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server2" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];


    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName =NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    return securityPolicy;
}

//http://10.10.55.191:8005/service-system/platform/file/fileUpload


- (void)ff{
    // 初始化Session对象
    self.session = [AFHTTPSessionManager manager];
    // 设置请求接口回来的时候支持什么类型的数据
    self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain", nil];
    self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.session GET:@"http://10.10.55.151:8005/service-system/platform/file" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载的进度");

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功:%@", responseObject);
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"---------%@",str);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);

    }];
    
//    AFNetworkReachabilityManager *netWorkingManager = [AFNetworkReachabilityManager sharedManager];
//    NSString *url_string = @"http://10.10.55.151:8005/service-system/platform/file";
//    NSURL *URL = [NSURL URLWithString:url_string];
//    url_string = [url_string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html",  nil];
//    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
////        [netWorkingManager stopMonitoring];
//
//        NSLog(@"rrrrr");
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    
}


- (void)fffff{
    
    UIImage *image = [UIImage imageNamed:@"2"];
    //NSData转换为UIImage
    //    NSData *imageData = [NSData dataWithContentsOfFile: imagePath];
    //    UIImage *image = [UIImage imageWithData: imageData];


    //UIImage转换为NSData
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString * imagePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"2.png"];
    [imageData writeToFile:imagePath atomically:YES];
    NSLog(@"%@",imagePath);
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://10.10.55.151:8005/service-system/platform/file/fileUpload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        UIImage *image = [UIImage imageNamed:@"2"];
//        NSData *data = UIImagePNGRepresentation(image);
//        [formData appendPartWithFileData:data name:@"2" fileName:@"newPhoto.png" mimeType:@"image/png"];
        
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imagePath] name:@"file" fileName:@"2.png" mimeType:@"image/png" error:nil];
        NSLog(@"%@",[NSURL fileURLWithPath:imagePath]);
    } error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                  // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          
                      } else {
                          NSLog(@"--------------success %@ %@", response, responseObject);
                          NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          NSLog(@"---------%@",str);
                      }
                  }];
    
    [uploadTask resume];
    
}

- (void)startUseCos:(NSString *)sign{
    
    
    
    myClient = [[COSClient alloc] initWithAppId:@"1252070843" withRegion:@"bj"];
    
    
    COSObjectPutTask *task = [COSObjectPutTask new];
    task.filePath = @"/Users/zhangwenze/Desktop/中科软工作空间/腾讯云使用/上传下载/Testwz/Testwz/Michael Jackson.jpg";
    task.fileName = @"Michael Jackson";
    task.bucket = @"cos1";
    task.attrs = @"customAttribute";
    task.directory = @"";
    task.insertOnly = YES;
    task.sign = sign;
    
    myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        COSObjectUploadTaskRsp *rsp = (COSObjectUploadTaskRsp *)resp;
        if (rsp.retCode == 0) {
            //            strong.text = rsp.sourceURL;
            NSLog(@"%@",rsp.sourceURL);
        }else{
            NSLog(@"rsp.descMsg = %@",rsp.descMsg);
            NSLog(@"rsp.retCode = %d",rsp.retCode);
            
        }
    };
    //    myClient.progressHandler = ^(NSInteger bytesWritten,NSInteger totalBytesWritten,NSInteger totalBytesExpectedToWrite){
    //        //progress
    //    };
    [myClient putObject:task];
    
}

- (void)getDirectory:(NSString *)sign{
    COSListDirCommand *cm = [COSListDirCommand new];
    cm.directory = @"";
    cm.bucket = @"cos1";
    cm.sign = sign;
    cm.num = 10;
    cm.pageContext = @"";
    cm.prefix = @"";
    myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        COSDirListTaskRsp *rsp = (COSDirListTaskRsp *)resp;
        if (rsp.retCode == 0) {
            NSLog(@"query sucess！=%@",rsp.data);
            NSString *jsonString = nil;
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:rsp.infos
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
            //            imgUrl.text = jsonString;
            NSLog(@"%@",jsonString);
        }else{
            //            imgUrl.text = rsp.descMsg;
            NSLog(@"%@",rsp.descMsg);
            NSLog(@"%@",context);
            NSLog(@"%d",rsp.retCode);
            
        }
        
    };
    [myClient listDir:cm];
}

- (void)yuming{
    //testwz01-1252070843.picsh.myqcloud.com
    //tencentyun-1252821871.picsh.myqcloud.com
    
    /*
     POST /ocr/idcardHTTP/1.1
     Authorization: FL26MsO1nhrZGuXdin10DE5tnDdhPTEwMDAwMDEmYj1xaW5pdXRlc3QyJms9QUtJRG1PNWNQVzNMREdKc2FyREVEY1ExRnByWlZDMW9wZ3FYJnQ9MTQ2OTE3NTIzMCZlPTE0NjkxNzYyMzA=
     Host: recognition.image.myqcloud.com
     Content-Length: 302
     Content-Type: "application/json"
     
     {
     "appid":11111,
     "bucket":"test",
     "card_type":0,
     "url_list":[
     "http://www.test.com/aaa.jpg",
     "http://www.test.com/bbb.jpg"
     ]
     }
     
     
     签名
     a=1252070843&b=testwz01&k=AKIDhLpEXhpcQ4azDJtya1ObeWUI0Xu6F1oQ&t=1510716110&e=1511576428
     
     AKIDhLpEXhpcQ4azDJtya1ObeWUI0Xu6F1oQ
     ZxAKJ8lDaqvpZ8WyHe1Ga4TjpmY8Ynqi
     
     testwz01-1252070843.picsh.myqcloud.com
     
     ZTFlMGM5MmYzYmMzYThhNzhhMTE0ODhjMDdiOTc3MmVmODliMGVlZWE9MTI1MjA3MDg0MyZiPXRlc3R3ejAxJms9QUtJRGhMcEVYaHBjUTRhekRKdHlhMU9iZVdVSTBYdTZGMW9RJnQ9MTUxMDU2NTY2MiZlPTE1MTA2NTIwNjI=
     
     
     a=1255452243&b=test1&k=AKID60e2B8oGRL2Vkla7SaVCfvxlLhql77Td&t=1510565662&e=1510652062
     
     test1-1255452243.picsh.myqcloud.com
     NzQ5NzI1MGU4MjM5MzMwYTVhYmE4NGQxZjM1MDUzMzBiNTViMWYwM2E9MTI1NTQ1MjI0MyZiPXRlc3QxJms9QUtJRDYwZTJCOG9HUkwyVmtsYTdTYVZDZnZ4bExocWw3N1RkJnQ9MTUxMDU2NTY2MiZlPTE1MTA2NTIwNjI=
     */
    
    
    
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:@"http://service.image.myqcloud.com/ocr/idcard"];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10.0];
    [request addValue:@"n22yrxUUSPCBa9phFYI7t0zyVYphPTEyNTIwNzA4NDMmaz0iQUtJRGhMcEVYaHBjUTRhekRKdHlhMU9iZVdVSTBYdTZGMW9RIiZlPTAmdD0xNTEwODI0NjMzJnI9MTAzMTgxNzE4NiZmPS8xMjUyMDcwODQzL25ld3Rlc3QmYj1uZXd0ZXN0" forHTTPHeaderField:@"Authorization"];
    
    //设置请求头
    [request addValue:@"newtest-1252070843.picsh.myqcloud.com" forHTTPHeaderField:@"Host"];
    //    [request addValue:@"302" forHTTPHeaderField:@"Content-Length"];
    
    //设置缓存策略
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    
    // 创建字典参数，将参数放入字典中，可防止程序员在主观意识上犯错误，即参数写错。
    NSDictionary *parametersDict = @{@"appid":@"1252070843",@"bucket":@"newtest",@"card_type":[NSNumber numberWithInt:0],@"url_list":@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510574412649&di=80ecc3d5c310d8c3503b27c56c90f68b&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20130530%2FImg377522814.jpg"]};
    // 遍历字典，以“key=value&”的方式创建参数字符串。
    NSMutableString *parameterString = [[NSMutableString alloc]init];
    int pos =0;
    for (NSString *key in parametersDict.allKeys) {
        // 拼接字符串
        [parameterString appendFormat:@"%@=%@", key, parametersDict[key]];
        if(pos<parametersDict.allKeys.count-1){
            [parameterString appendString:@"&"];
        }
        pos++;
    }
    
    
    
    
    // NSString转成NSData数据类型。
    NSData *parametersData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
    //设置请求报文
    [request setHTTPBody:parametersData];
    
    NSString *str = [NSString stringWithFormat:@"%lu",request.HTTPBody.length];
    [request addValue:str forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    // 3.获得会话对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 7、创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"post error :%@",error.localizedDescription);
        }else {
            NSLog(@"%@",data);
            // 如果请求成功，则解析数据。
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 11、判断是否解析成功
            if (error) {
                NSLog(@"post error :%@",error.localizedDescription);
            }else {
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                NSLog(@"post success :%@",object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面...
                });
            }
        }
    }];
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
    
}

- (void)aftestwz:(NSString *)signStr{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]; //不设置会报-1016或者会有编码问题
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; //不设置会报-1016或者会有编码问题
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //不设置会报 error 3840
    //    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    //    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://service.image.myqcloud.com/ocr/idcard" parameters:nil error:nil];
    //    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //
    //    [request addValue:@"YjJkMWE4Y2FjZWZmZDkwNmM3NDdhYThiOWIwMzA2ODQ4NTA0ODYzOWE9MTI1MjA3MDg0MyZiPXRlc3R3ejAxJms9QUtJRGhMcEVYaHBjUTRhekRKdHlhMU9iZVdVSTBYdTZGMW9RJnQ9MTUxMDcxNjExMCZlPTE1MTE1NzY0Mjg=" forHTTPHeaderField:@"Authorization"];
    //
    //设置请求头
    //    [request addValue:@"testwz01-1252070843.picsh.myqcloud.com" forHTTPHeaderField:@"Host"];
    
    [manager.requestSerializer setValue:@"newtest-1252070843.picsh.myqcloud.com"   forHTTPHeaderField:@"Host"];
    [manager.requestSerializer setValue:signStr   forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json"   forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSDictionary *parametersDict = @{
                                     @"appid":@"1255452243",
                                     @"bucket":@"test1",
                                     @"card_type":[NSNumber numberWithInt:0],
                                     @"url_list":@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510574412649&di=80ecc3d5c310d8c3503b27c56c90f68b&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20130530%2FImg377522814.jpg"]};
    
    //    NSString * paramStr = [self dictionaryToJson:parametersDict];
    //    NSData *body  =[paramStr dataUsingEncoding:NSUTF8StringEncoding];
    //    [request setHTTPBody:body];
    //    NSString *str = [NSString stringWithFormat:@"%lu",request.HTTPBody.length];
    //    [request addValue:str forHTTPHeaderField:@"Content-Length"];
    
    //发起请求
    //    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error)
    //      {
    //          if(error){
    //              NSLog(@"error = %@",error);
    //          }
    //          NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //          NSLog(@"%@",dic);
    ////          access(dic);
    //
    //      }] resume];
    
    [manager POST:@"http://service.image.myqcloud.com/ocr/idcard" parameters:parametersDict progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

