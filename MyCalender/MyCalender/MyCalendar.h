//
//  MyCalendar.h
//  MyCalender
//
//  Created by Yumukim on 15/10/26.
//  Copyright © 2015年 Yumukim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCalendar : UIView

- (void)createCalendarViewWith:(NSDate *)date;
- (NSDate *)nextMonth:(NSDate *)date;
- (NSDate *)lastMonth:(NSDate *)date;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * headLabel;

@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

@end
