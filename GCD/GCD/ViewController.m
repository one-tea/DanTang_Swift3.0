//
//  ViewController.m
//  GCD
//
//  Created by Kevin on 16/10/12.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self mainQueue];
//    [self privateQueue];
    [self globalQueue];
}
-(void)mainQueue{

        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSInteger i = 0; i < 10; i++) {
                NSLog(@"主线程任务2_i:%ld",i);
                [NSThread sleepForTimeInterval:0.5];
            }
        });
}
-(void)privateQueue{
    //串行私有队列
    dispatch_queue_t queue=dispatch_queue_create("com.zkk", NULL);
    //异步任务1加入队列中
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"私有队列任务1");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"私有队列任务1_i:%ld",i);
            [NSThread sleepForTimeInterval:0.5];
        }
     
    });
    //同步任务2加入队列中
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"私有队列任务2");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"私有队列任务2_i:%ld",i);
            [NSThread sleepForTimeInterval:0.5];
        }
        
    });
    
}
-(void)globalQueue{
    //并行全局队列
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //添加一个同步任务1
    dispatch_async(globalQueue, ^{
        NSLog(@"全局队列任务1");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"全局队列任务1_i:%ld",i);
            [NSThread sleepForTimeInterval:0.5];
        }
    });
    //添加一个同步任务2
    dispatch_sync(globalQueue, ^{
        NSLog(@"全局队列任务2");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"全局队列任务2_i:%ld",i);
            [NSThread sleepForTimeInterval:0.5];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
