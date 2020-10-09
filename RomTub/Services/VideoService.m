//
//  VideoService.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "VideoService.h"
#import "Video.h"
#import "XMLParser.h"
#import "ImageDownloadOperation.h"

@interface VideoService()

@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSMutableDictionary <NSString *,NSArray <NSOperation *> *>*operations;
@property (nonatomic,strong) id<ParserProtocol> parser;

@end


@implementation VideoService

- (instancetype)initWithParser:(id<ParserProtocol>)parser{
    self = [super init];
    if (self){
        _parser = parser;
        _queue = [NSOperationQueue new];
        _operations = [NSMutableDictionary new];
        
    }
    return self;
}

- (NSURLSession *)session{
    if (!_session){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return _session;
}

- (void)loadVideos:(void (^)(NSArray<Video *> *, NSError *))completion{
    
    NSURL *url = [NSURL URLWithString:@"https://www.ted.com/themes/rss/id"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error){
            completion(nil,error);
            return;
        }
        [self.parser parseVideos:data completion:completion];
    }];
    [dataTask resume];
}


- (void)loadImageForURL:(NSString *)url completion:(void (^)(UIImage *))completion {
    [self cancelDownloadingForUrl:url];
    ImageDownloadOperation *operation = [[ImageDownloadOperation alloc] initWithUrl:url];
    self.operations[url] = @[operation];
    operation.completion = ^(UIImage *image) {
        completion(image);
    };
    [self.queue addOperation:operation];
}

- (void)cancelDownloadingForUrl:(NSString *)url{
    NSArray<NSOperation *> *operations = self.operations[url];
    if (!operations) { return; }
    for (NSOperation *operation in operations) {
        [operation cancel];
    }
}

@end
