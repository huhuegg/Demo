//
//  YukeyVoiceRecordHelper.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YukeyStartRecorderCompletion)();
typedef void(^YukeyStopRecorderCompletion)();
typedef void(^YukeyPauseRecorderCompletion)();
typedef void(^YukeyResumeRecorderCompletion)();
typedef void(^YukeyCancellRecorderDeleteFileCompletion)();
typedef void(^YukeyRecordProgress)(float progress);
typedef void(^YukeyPeakPowerForChannel)(float peakPowerForChannel);


@interface YukeyVoiceRecordHelper : NSObject

@property (nonatomic, copy) YukeyStopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) YukeyRecordProgress recordProgress;
@property (nonatomic, copy) YukeyPeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)startRecordingWithPath:(NSString *)path StartRecorderCompletion:(YukeyStartRecorderCompletion)startRecorderCompletion;
- (void)pauseRecordingWithPauseRecorderCompletion:(YukeyPauseRecorderCompletion)pauseRecorderCompletion;
- (void)resumeRecordingWithResumeRecorderCompletion:(YukeyResumeRecorderCompletion)resumeRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(YukeyStopRecorderCompletion)stopRecorderCompletion;
- (void)cancelledDeleteWithCompletion:(YukeyCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;

@end
