//
//  NewsApi.m
//  AoYangBuild
//
//  Created by wl on 15/11/26.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "NewsApi.h"

@implementation NewsApi{
    NSDictionary *_param;
    NSString *_ID;
    NSString *_comment;
    BOOL send;
}

- (id)initWithItem:(NSString *)item andPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        if (page==0) {
            _param = @{@"filter[category_name]":item};
        }else{
            NSString *curentPage =[NSString stringWithFormat:@"%ld",(long)page];
            _param =@{@"filter[category_name]":item,@"page":curentPage};
        }
    }
    return self;
}

-(id)initWithNewsID:(NSString *)ID andPage:(NSInteger)page{
    self=[super init];
    if (self) {
        _ID=ID;
    }
    return self;
}
-(id)initWithComment:(NSString *)comment andNewsID:(NSString *)ID{
    self=[super init];
    if (self) {
        _comment=comment;
        _ID=ID;
        if (comment) {
            send=YES;
            NSString *username =[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
            _param=@{@"data[content]":comment,@"data[author]":username};
        }
    }
    return self;

}

- (NSString *) requestUrl{
    if (send) {
        return [NSString stringWithFormat:@"/posts/%@/comments",_ID];
    }else if(_ID){
        return [NSString stringWithFormat:@"/posts/%@/comments",_ID];
       // return [NSString stringWithFormat:@"/posts/<%@>/comments?data[content]=%@",_ID,_comment];
    }else if (_param){
         return @"/posts";
    }
    return nil;
    //http://112.80.40.185/wp-json/posts/<id>/comments GET
   // http://112.80.40.185/wp-json/posts/<id>/comments POST
}

- (YTKRequestMethod) requestMethod{
    if (_comment) {
        return YTKRequestMethodPost;
    }
    return YTKRequestMethodGet;
}

- (id)requestArgument{
    return _param;
}

- (id) responseJSONObject{
    return self.requestOperation.responseObject;
}

-(NSDictionary *)requestHeaderFieldValueDictionary{
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *base64LoginString =[user objectForKey:@"basekey"];
    if (!base64LoginString) {
        return nil;
    }
    return [[NSDictionary alloc] initWithObjects:@[base64LoginString] forKeys:@[@"Authorization"]];
}
@end
