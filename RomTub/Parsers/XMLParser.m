//
//  XMLParser.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "XMLParser.h"
#import "Video.h"

@interface XMLParser() <NSXMLParserDelegate>

@property (nonatomic,copy) void(^completion)(NSArray <Video *> *,NSError *);
@property (nonatomic, strong) NSMutableDictionary *videoDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@property (nonatomic, strong) NSMutableArray *videos;

@end


@implementation XMLParser 

- (void)parseVideos:(NSData *)data completion:(void (^)(NSArray<Video *> *, NSError *))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - Parser delegate methods

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    if (self.completion){
        self.completion(nil, parseError);
    }
    [self resetParserState];

}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.videos = [NSMutableArray new];
}

  static BOOL isOpen;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if ([elementName isEqualToString:@"item"]) {
        self.videoDictionary = [NSMutableDictionary new];
        isOpen = YES;
    } else if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"media:credit"] || [elementName isEqualToString:@"itunes:duration"] || [elementName isEqualToString:@"description"] || [elementName isEqualToString:@"link"] )  {
        self.parsingString = [NSMutableString new];
    } else
        if ([elementName isEqualToString:@"itunes:image"]){
            self.parsingString = [NSMutableString stringWithString:attributeDict[@"url"]];
        } else
            if (([elementName isEqualToString:@"media:content"]) && (isOpen)){
                self.parsingString = [NSMutableString stringWithString:attributeDict[@"url"]];
                isOpen = !isOpen;
            }
    
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.parsingString appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (self.parsingString) {
        [self.videoDictionary setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    }
    if ([elementName isEqualToString:@"item"]) {
        Video *video = [[Video alloc] initWithDictionary:self.videoDictionary];
        self.videoDictionary = nil;
        [self.videos addObject:video];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if (self.completion){
        self.completion(self.videos, nil);
    }
    [self resetParserState];
}

#pragma mark - Private methods

- (void)resetParserState {
    self.completion = nil;
    self.videos = nil;
    self.videoDictionary = nil;
    self.parsingString = nil;
}



@end
