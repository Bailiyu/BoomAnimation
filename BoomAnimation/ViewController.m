//
//  ViewController.m
//  BoomAnimation
//
//  Created by Fancy on 16/3/1.
//  Copyright © 2016年 Fancy. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/CoreAnimation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    //设置发射位置
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0,viewBounds.size.height);
    //发射源的尺寸大小、
    fireworksEmitter.emitterSize =CGSizeMake(viewBounds.size.width/2.0,0.0);
    //发射模式
    fireworksEmitter.emitterMode = kCAEmitterLayerOutline;
    //发射形状
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    //渲染模式
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    //用于初始化随机数函数的种子
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
    rocket.velocity			= 380;
    rocket.velocityRange	= 100;
    rocket.yAcceleration	= 75;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents			= (id) [[UIImage imageNamed:@"1"] CGImage];
    rocket.scale			= 0.2;
    rocket.color			= [[UIColor redColor] CGColor];
    rocket.greenRange		= 1.0;		// different colors
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    rocket.spinRange		= M_PI;		// slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0;
    burst.scale				= 2.5;
    burst.redSpeed			=-1.5;		// shifting
    burst.blueSpeed			=+1.5;		// shifting
    burst.greenSpeed		=+1.0;		// shifting
    burst.lifetime			= 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate			= 400;
    spark.velocity			= 125;
    spark.emissionRange		= 2* M_PI;	// 360 deg
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 3;
    
    spark.contents			= (id) [[UIImage imageNamed:@"2"] CGImage];
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.25;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    //将fireworkEmitter添加到图层上
    [self.view.layer addSublayer:fireworksEmitter];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
