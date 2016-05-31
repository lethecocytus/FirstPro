//
//  ViewController.m
//  MyCalender
//
//  Created by Yumukim on 15/10/26.
//  Copyright © 2015年 Yumukim. All rights reserved.
//

#define ScreenBounds [UIScreen mainScreen].bounds]
#define Width(count) [[UIScreen mainScreen]bounds].size.width * count
#define Height(count) [[UIScreen mainScreen]bounds].size.height * count


#import "ViewController.h"
#import "MyCalendar.h"


@interface ViewController ()<UIScrollViewAccessibilityDelegate>

@property (strong,nonatomic) UIImageView * myView;
@property (strong,nonatomic) MyCalendar * calendarView;
@property (strong,nonatomic) UIScrollView * scrollView;

@end

@implementation ViewController
{
    NSDateComponents *timeComponent;
    NSString * BGName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myView = [[UIImageView alloc]initWithFrame:ScreenBounds;
                   [self.view addSubview:self.myView];
                   [self backgroundImgSwitchByTime];
                   self.myView.userInteractionEnabled = YES;
                   self.myView.image = [UIImage imageNamed:BGName];
                   //    self.myView.alpha = 0.8;
                                      
                   
                   //创建ScrollView
                   self.scrollView = [[UIScrollView alloc]initWithFrame:ScreenBounds;
                                      //可滚动区域
                                      self.scrollView.contentSize = CGSizeMake(Width(100),Height(1));
                                      self.scrollView.pagingEnabled = YES;
                                      //是否允许反弹
                                      self.scrollView.bounces = YES;
                                      //指定代理人
                                      self.scrollView.delegate = self;
                                      //偏移量
                                      //    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 50, 0);
                                      [self.view addSubview:self.scrollView];
                                      
                                      
                                      //添加图片到scrollview
                                      MyCalendar * calendarView = [[MyCalendar alloc]
                                                                   initWithFrame:CGRectMake(Width(0), 0, Width(1),Height(1))];
                                      calendarView.date = [NSDate date];
                                      [self.scrollView addSubview:calendarView];
                                      
                                      
                                      calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
                                          NSLog(@"%ld-%ld-%ld", (long)year,month,(long)day);
                                      };
                                      
                                      //动态时间展示
                                      [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(UpdateText:) userInfo:nil repeats:NO];
                                      
                                      
                                      MyCalendar * calendarView1 = [[MyCalendar alloc]
                                                                    initWithFrame:CGRectMake(Width(1), 0, Width(1),Height(1))];
                                      [self.scrollView addSubview:calendarView1];
                                      calendarView1.date = [calendarView nextMonth:[NSDate date]];

                                      
                                      calendarView1.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
                                          NSLog(@"%ld-%ld-%ld", (long)year,month,(long)day);
                                      };
                                      }
                                      
                                      //#pragma -mark 动态时间展示
                                      -(void)UpdateText:(NSTimer *)timer{
                                          NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
                                          [formatter setDateFormat:@"aa hh:mm:ss"];
                                          self.calendarView.timeLabel.text= [formatter stringFromDate:[NSDate date]];
                                          [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(UpdateText:) userInfo:nil repeats:NO];
                                      }
                                      
                                      -(void)backgroundImgSwitchByTime
                                      {
                                          timeComponent=[[NSCalendar currentCalendar] components:NSCalendarUnitHour  fromDate:[NSDate date]];
                                          NSInteger hour=[timeComponent hour];
                                          if (hour>=5&&hour<8)
                                              BGName = @"morning.jpg";
                                          else if(hour>=8&&hour<11)
                                              BGName = @"forenoon.jpg";
                                          else if(hour>=11&&hour<13)
                                              BGName = @"noon.jpg";
                                          else if(hour>=13&&hour<16)
                                              BGName = @"afternoon.jpg";
                                          else if(hour>=16&&hour<19)
                                              BGName = @"dusk.jpg";
                                          else
                                              BGName = @"night.jpg";
                                      }
                                      
                                      //#pragma - mark UISrollview的代理方法
                                      //只要一滑动就会走的方法
                                      -(void)scrollViewDidScroll:(UIScrollView *)scrollView   {
                                          
                                          NSLog(@"正在滑动");
                                          NSLog(@"%f",scrollView.contentOffset.x);
                                          
                                      }
                                      
                                      //1开始拖拽
                                      -(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
                                          
                                          NSLog(@"开始拖拽");
                                          
                                      }
                                      
                                      
                                      //2结束拖拽
                                      -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
                                          
                                          NSLog(@"结束拖拽");
                                          
                                      }
                                      
                                      //开始减速
                                      -(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
                                          
                                          NSLog(@"开始减速");
                                          
                                      }
                                      
                                      //结束减速（意味完全停止）
                                      -(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
                                          
                                          NSLog(@"结束减速");
                                          NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
                                          NSLog(@"滑动到了%ld页",(long)page);
                                          
                                      }
                                      
                                      
                                      
                                      - (void)didReceiveMemoryWarning {
                                          [super didReceiveMemoryWarning];
                                          // Dispose of any resources that can be recreated.
                                      }
                                      
                                      /*
                                       #pragma mark - Navigation
                                       
                                       // In a storyboard-based application, you will often want to do a little preparation before navigation
                                       - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
                                       // Get the new view controller using [segue destinationViewController].
                                       // Pass the selected object to the new view controller.
                                       }
                                       */
                                      
                                      @end
