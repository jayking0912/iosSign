//
//  HexToUIcolor.h
//  OneQianDao
//
//  Created by pi on 07/04/2018.
//  Copyright © 2018 jayking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HexToUIcolor : NSObject
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length ;
+ (UIColor *) colorWithHexString: (NSString *) hexString;
@end
