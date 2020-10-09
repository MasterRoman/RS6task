//
//  EntityVideo+CoreDataProperties.h
//  RomTub
//
//  Created by Admin on 30.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//
//

#import "EntityVideo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EntityVideo (CoreDataProperties)

+ (NSFetchRequest<EntityVideo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nonatomic) BOOL isLike;
@property (nullable, nonatomic, copy) NSString *link;
@property (nullable, nonatomic, copy) NSString *linkVideo;
@property (nullable, nonatomic, copy) NSString *speaker;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *titleVideo;
@property (nullable, nonatomic, copy) NSString *videoDescription;

@end

NS_ASSUME_NONNULL_END
