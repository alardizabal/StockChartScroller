//
//  AALViewController.m
//  StockChartScroll
//
//  Created by Albert Lardizabal on 7/13/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALViewController.h"

@interface AALViewController ()

@property (weak, nonatomic) NSString *stockTicker;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIWebView *stockChartOne;
@property (weak, nonatomic) IBOutlet UIWebView *stockChartTwo;
@property (weak, nonatomic) IBOutlet UIWebView *stockChartThree;

@end

@implementation AALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Stock Scroller";
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(loadNewStock:)];
    
    [self.stockChartOne addGestureRecognizer:tapRecognizer];
    [self.stockChartTwo addGestureRecognizer:tapRecognizer];
    [self.stockChartThree addGestureRecognizer:tapRecognizer];
    
    tapRecognizer.delegate = self;
    
    self.stockTicker = @"AAPL";
    
    [self loadChart];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadNewStock:(UITapGestureRecognizer *)recognizer {
    
    NSLog(@"Hi");
    
    NSUInteger randomInteger = arc4random_uniform(3) + 1;
    
    switch (randomInteger) {
        case 3:
            self.stockTicker = @"AMZN";
            break;
            
        case 2:
            self.stockTicker = @"TSLA";
            break;
            
        case 1:
            self.stockTicker = @"GOOGL";
            break;
            
        default:
            break;
    }
    
    [self loadChart];
    
}

- (void) loadChart

{
    
    NSURL *dailyURL;
    NSURL *weeklyURL;
    NSURL *monthlyURL;
    
    NSString *dailyURLstring;
    NSString *weeklyURLstring;
    NSString *monthlyURLstring;
    
    dailyURLstring=[[NSString alloc] initWithFormat:@"http://finviz.com/chart.ashx?t=%@&ty=c&ta=1&p=d&s=l", self.stockTicker];
    weeklyURLstring=[[NSString alloc] initWithFormat:@"http://finviz.com/chart.ashx?t=%@&ty=c&ta=0&p=w&s=l", self.stockTicker];
    monthlyURLstring=[[NSString alloc] initWithFormat:@"http://finviz.com/chart.ashx?t=%@&tfy=c&ta=0&p=m&s=l", self.stockTicker];
    
    dailyURL=[[NSURL alloc] initWithString:dailyURLstring];
    weeklyURL=[[NSURL alloc] initWithString:weeklyURLstring];
    monthlyURL=[[NSURL alloc] initWithString:monthlyURLstring];
    
    [self.stockChartOne loadRequest:[NSURLRequest requestWithURL:dailyURL]];
    [self.stockChartTwo loadRequest:[NSURLRequest requestWithURL:weeklyURL]];
    [self.stockChartThree loadRequest:[NSURLRequest requestWithURL:monthlyURL]];
    
}

@end
