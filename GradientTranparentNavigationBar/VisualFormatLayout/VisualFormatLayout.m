//
//  VisualFormatLayout.m
//  AutolayoutDemo
//
//  Created by Aiguang Li on 16/4/18.
//  Email: Aiguang.Li@gmail.com
//  Github: https://github.com/AiguangLi/
//  Copyright © 2016年 mooeen. All rights reserved.
//

#import "VisualFormatLayout.h"

@implementation VisualFormatLayout

//This function can be used for any constraints using VFL
+ (void)autoLayout:(UIView *)superview visualFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    for (id o in [views allValues]) {
        if ([o isKindOfClass:[UIView class]]) {
            UIView *v = (UIView *)o;
            if (superview != v) {
                v.translatesAutoresizingMaskIntoConstraints = NO;
            }
        }
    }
    NSMutableArray* constraints = [[NSMutableArray alloc]init];
    for (NSString *s in formats) {
        [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:s options:0 metrics:metrics views:views]];
    }
    [superview addConstraints:constraints];
}

@end
