//
//  XDMarkupStripper.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDMarkupStripper.h"

#import "XDEntityTables.h"
#import "XDCorePreprocessorMacros.h"

@implementation XDMarkupStripper


- (void)dealloc
{
    XD_RELEASE_SAFELY(_strings);
    [super dealloc];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [_strings addObject:string];
}

- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID {
    return [[[XDEntityTables shareInstance] iso88591] objectForKey:name];
}

#pragma mark - public
- (NSString *)parse:(NSString *)text {
    _strings = [[NSMutableArray alloc] init];
    NSString *document = [NSString stringWithFormat:@"<x>%@</x>",text];
    NSData *data = [document dataUsingEncoding:text.fastestEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    XD_RELEASE_SAFELY(parser);
    
    NSString *result = [_strings componentsJoinedByString:@""];
    XD_RELEASE_SAFELY(_strings);

    return result;
}

@end
