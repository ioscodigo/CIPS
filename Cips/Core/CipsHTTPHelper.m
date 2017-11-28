//
//  HTTPHelper.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "CipsHTTPHelper.h"

@implementation CipsHTTPHelper



static CipsHTTPHelper *sharedInstance = nil;

+(CipsHTTPHelper*)instance
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[CipsHTTPHelper alloc] init];
    });
    return sharedInstance;
}


-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        _keyChain = [[KeychainWrapper alloc] init];
    }
    return self;
}

-(void)requestMulitpartDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withBlock:(void (^)(CipsHTTPResponse *response))block{
    [self requestMulitpartDataWithMethod:method WithUrl:url withParameter:param withHeader:nil withBlock:block];
}

-(void)requestMulitpartDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block{
    
    NSString *boundary = nil;
    NSData *post = [self multipartDataWithParameters:param boundary:&boundary];
    NSMutableDictionary *head = [[NSMutableDictionary alloc] initWithDictionary:@{@"Content-Type":[@"multipart/form-data; boundary=" stringByAppendingString:boundary]}];
    [self request:method withURL:url withBody:post withHeaders:head withBlock:block];
}

-(void)requestFormDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withBlock:(void (^)(CipsHTTPResponse *response))block {
    [self requestFormDataWithMethod:method WithUrl:url withParameter:param withHeader:nil withBlock:block];
}

-(void)requestFormDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block {
    NSMutableDictionary *head = [[NSMutableDictionary alloc] initWithDictionary:@{@"Content-Type":@"application/x-www-form-urlencoded"}];
    if(headers != nil){
        [head addEntriesFromDictionary:headers];
    }
    NSLog(@"url %@",url);
    NSString *query = [self joinQueryWithDictionary:param];
    NSData *data = [query dataUsingEncoding:NSASCIIStringEncoding];
    NSString *length = [NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
    [head addEntriesFromDictionary:@{@"Content-Length":length}];
    [self request:method withURL:url withBody:data withHeaders:head withBlock:block];
}

-(void)requestJSONWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block{
    NSMutableDictionary *head = [[NSMutableDictionary alloc] initWithDictionary:@{@"Content-Type":@"application/json"}];
    if(headers != nil){
        [head addEntriesFromDictionary:headers];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    NSString *query = [self joinQueryWithDictionary:param];
    NSString *length = [NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
    [head addEntriesFromDictionary:@{@"Content-Length":length}];
    [self request:method withURL:url withBody:data withHeaders:head withBlock:block];
}

-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBlock:(void (^)(CipsHTTPResponse *response))block {
    [self request:method withURL:URL withBody:nil withHeaders:nil withBlock:block];
}

-(void)request:(HTTPMethod)method withURL:(NSString *)URL withHeaders:(NSDictionary *)header withBlock:(void (^)(CipsHTTPResponse *response))block{
    [self request:method withURL:URL withBody:nil withHeaders:header withBlock:block];
}

-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBody:(NSData *)body withBlock:(void (^)(CipsHTTPResponse *response))block {
    [self request:method withURL:URL withBody:body withHeaders:nil withBlock:block];
}

-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBody:(NSData *)body withHeaders:(NSDictionary *)header withBlock:(void (^)(CipsHTTPResponse *response))block{
    NSString *methods = @"";
    switch (method) {
        case GET:
            methods = @"GET";
            break;
        case POST:
            methods = @"POST";
            break;
        case PUT:
            methods = @"PUT";
            break;
        case DELETE:
            methods = @"DELETE";
        default:
            break;
    }
    NSURLRequest *req = [self request:methods withUrl:URL withBody:body withHeader:header];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        CipsHTTPResponse *respon = [[CipsHTTPResponse alloc] init];
        
        respon.responseCode = [(NSHTTPURLResponse *)response statusCode];
        respon.error = error;
        if(!error){
        NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError){
            respon.error = jsonError;
            respon.message = @"Not JSON Format";
        }else{
            respon.data = json;
        }
        respon.responString = responseStr;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(respon);
        });
       
    }] resume];
}



-(NSURLRequest *)request:(NSString *)method withUrl:(NSString *)URL withBody:(NSData *)body withHeader:(NSDictionary *)headers{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:method];
    if(body != nil){
        [request setHTTPBody:body];
    }
    if(headers != nil){
        [request setAllHTTPHeaderFields:headers];
    }
    return request;
}

// Objective-C method for composing a HTTP multipart/form-data body.
// Provide parameters and data in a NSDictionary. Outputs a NSData request body.
// License: Public Domain
// Author:  Leonard van Driel, 2012

#pragma mark - Helper

- (void)addFormDataWithParameters:(NSDictionary *)parameters toURLRequest:(NSMutableURLRequest *)request
{
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    NSString *query = [self joinQueryWithDictionary:parameters];
    request.HTTPBody = [query dataUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - Content-type: multipart/form-data

- (void)addMultipartDataWithParameters:(NSDictionary *)parameters toURLRequest:(NSMutableURLRequest *)request
{
    NSString *boundary = nil;
    NSData *post = [self multipartDataWithParameters:parameters boundary:&boundary];
    [request setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-type"];
    request.HTTPBody = post;
}

- (NSData *)multipartDataWithParameters:(NSDictionary *)parameters boundary:(NSString **)boundary
{
    NSMutableData *result = [[NSMutableData alloc] init];
    if (boundary && !*boundary) {
        char buffer[32];
        for (NSUInteger i = 0; i < 32; i++) buffer[i] = "0123456789ABCDEF"[rand() % 16];
        NSString *random = [[NSString alloc] initWithBytes:buffer length:32 encoding:NSASCIIStringEncoding];
        *boundary = [NSString stringWithFormat:@"MyApp--%@", random];
    }
    NSData *newline = [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *boundaryData = [[NSString stringWithFormat:@"--%@\r\n", boundary ? *boundary : @""] dataUsingEncoding:NSUTF8StringEncoding];
    
    for (NSArray *pair in [self flatten:parameters]) {
        [result appendData:boundaryData];
        [self appendToMultipartData:result key:pair[0] value:pair[1]];
        [result appendData:newline];
    }
    NSString *end = [NSString stringWithFormat:@"--%@--\r\n", boundary ? *boundary : @""];
    [result appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    return result;
}

- (void)appendToMultipartData:(NSMutableData *)data key:(NSString *)key value:(id)value
{
    if ([value isKindOfClass:NSData.class]) {
        NSString *name = key;
        if ([key rangeOfString:@"%2F"].length) {
            NSRange r = [name rangeOfString:@"%2F"];
            key = [key substringFromIndex:r.location + r.length];
            name = [name substringToIndex:r.location];
        }
        NSString *string = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n", name, key];
        [data appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:value];
    } else {
        NSString *string = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@", key, value];
        [data appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (NSString *)unescape:(NSString *)string
{
    return CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""), kCFStringEncodingUTF8));
}

- (NSString *)escape:(NSString *)string
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)string, NULL, CFSTR("*'();:@&=+$,/?!%#[]"), kCFStringEncodingUTF8));
}

- (NSString *)joinQueryWithDictionary:(NSDictionary *)dictionary
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSArray *pair in [self flatten:dictionary]) {
        if (result.length) [result appendString:@"&"];
        [result appendString:pair[0]];
        [result appendString:@"="];
//        [result appendString:[self escape:[pair[1] description]]];
        [result appendString:[pair[1] description]];
    }
    return result;
}

- (NSDictionary *)splitQueryWithString:(NSString *)string {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *pair in [string componentsSeparatedByString:@"&"]) {
        NSRange r = [pair rangeOfString:@"="];
        if (r.location == NSNotFound) {
            [result setObject:@"" forKey:[self unescape:pair]];
        } else {
            NSString *value = [self unescape:[pair substringFromIndex:r.location + r.length]];
            [result setObject:value forKey:[self unescape:[pair substringToIndex:r.location]]];
        }
    }
    return result;
}

- (NSArray *)flatten:(NSDictionary *)dictionary
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:dictionary.count];
    NSArray *keys = [dictionary.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys) {
        id value = [dictionary objectForKey:key];
        if ([value isKindOfClass:NSArray.class] || [value isKindOfClass:NSSet.class]) {
            NSString *k = [[self escape:key] stringByAppendingString:@"[]"];
            for (id v in value) {
                [result addObject:@[k, v]];
            }
        } else if ([value isKindOfClass:NSDictionary.class]) {
            for (NSString *k in value) {
                NSString *kk = [[self escape:key] stringByAppendingFormat:@"[%@]", [self escape:k]];
                [result addObject:@[kk, [value valueForKey:k]]];
            }
        } else {
            [result addObject:@[[self escape:key], value]];
        }
    }
    return result;
}

@end
