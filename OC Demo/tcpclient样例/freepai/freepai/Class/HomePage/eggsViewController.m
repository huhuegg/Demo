//
//  eggsViewController.m
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "eggsViewController.h"
#import "testMyScene.h"

@interface eggsViewController ()

@end

@implementation eggsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    
    _skview.showsFPS = YES;
    _skview.showsNodeCount = YES;
    [_skview sizeToFit];
    
    SKScene *scene = [testMyScene sceneWithSize:CGSizeMake(320, 320)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [_skview presentScene:scene];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
