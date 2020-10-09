//
//  EntityVideo+CoreDataProperties.m
//  RomTub
//
//  Created by Admin on 30.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//
//

#import "EntityVideo+CoreDataProperties.h"

@implementation EntityVideo (CoreDataProperties)

+ (NSFetchRequest<EntityVideo *> *)fetchRequest {
	 NSFetchRequest <EntityVideo *> *request = [NSFetchRequest fetchRequestWithEntityName:@"EntityVideo"];
       request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"titleVideo" ascending:YES]];
       return request;
}

@dynamic imageUrl;
@dynamic isLike;
@dynamic link;
@dynamic linkVideo;
@dynamic speaker;
@dynamic time;
@dynamic titleVideo;
@dynamic videoDescription;

@end
