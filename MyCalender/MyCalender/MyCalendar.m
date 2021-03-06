//
//  MyCalendar.m
//  MyCalender
//
//  Created by Yumukim on 15/10/26.
//  Copyright © 2015年 Yumukim. All rights reserved.
//

#import "AppDelegate.h"
#import "MyCalendar.h"

@implementation MyCalendar
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}



-(id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        
        for (int i = 0; i < 42; i++) {
            
            UIButton *button = [[UIButton alloc]init];
            
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    
    return  self;
    
}




#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.height / 8;
    // 1.year month
    self.headLabel = [[UILabel alloc] init];
    self.headLabel.text     = [NSString stringWithFormat:@"%li年%li月%li日",[self year:date],[self month:date],[self day:date]];
    self.headLabel.textColor=[UIColor whiteColor];
    self.headLabel.font = [UIFont fontWithName:@"Yuppy SC" size:itemH];
    self.headLabel.frame = CGRectMake(0, 0, self.frame.size.width, itemH);
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.headLabel];
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, itemH/2, self.frame.size.width, itemH/2)];
    //    self.timeLabel.backgroundColor=[UIColor orangeColor];
    self.timeLabel.font=[UIFont fontWithName:@"Yuppy SC" size:itemH/2];
    self.timeLabel.textColor=[UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
    
    // 2.weekday
    NSArray *array = @[@"一", @"二", @"三", @"四", @"五", @"六",@"日"];
    UIView *weekBg = [[UIView alloc] init];
    weekBg.backgroundColor = [UIColor orangeColor];
    weekBg.layer.cornerRadius=5;
    weekBg.frame = CGRectMake(0, CGRectGetMaxY(self.headLabel.frame)+5, self.frame.size.width, itemH);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont fontWithName:@"Yuppy SC" size:15];
        
        week.frame    = CGRectMake(itemW * i, 0, itemW, itemH);
        if([UIScreen mainScreen].bounds.size.height==736) {
            self.headLabel.frame = CGRectMake(0, 0, self.frame.size.width, itemH-10);
            weekBg.frame = CGRectMake(0, CGRectGetMaxY(self.headLabel.frame)+5, self.frame.size.width, itemH-10);
            week.frame    = CGRectMake(itemW * i, 0, itemW, itemH-10);
        }
        
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = [UIColor whiteColor];
        [weekBg addSubview:week];
    }
    NSLog(@"%@",[UIDevice currentDevice].model);
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        if ([UIScreen mainScreen].bounds.size.height==480) {
            y=y+15;
        }else if([UIScreen mainScreen].bounds.size.height==568) {
            y=y+10;
        }else if([UIScreen mainScreen].bounds.size.height==736) {
            y=y-5;
        }else
            y=y;
        dayButton.frame = CGRectMake(x, y, itemW, itemH);
        dayButton.titleLabel.font = [UIFont fontWithName:@"Yuppy SC" size:14];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5.0f;
        //        [dayButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [self totaldaysInMonth:[self lastMonth:date]];
        NSInteger daysInThisMonth = [self totaldaysInMonth:date];
        NSInteger firstWeekday    = [self firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        if ([self month:date] == [self month:[NSDate date]]) {
            
            NSInteger todayIndex = [self day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                [self setStyle_BeforeToday:dayButton];
                
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
                
            }
        }
    }
}

#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    _selectButton.selected = NO;
    dayBtn.selected = YES;
    _selectButton = dayBtn;
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
    self.headLabel.text = [NSString stringWithFormat:@"%li年%li月%li日",[comp year], [comp month], day];
}


#pragma mark - date button style

- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)setStyle_BeforeToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
}

- (void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor orangeColor]];
}

- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
}
@end
